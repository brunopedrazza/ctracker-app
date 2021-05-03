import sys
import signal
import time
from datetime import datetime, timedelta
from logging import getLogger

from typing import List

from django.core.management import BaseCommand
from django.db.utils import InterfaceError
from django.db.models import Q

from django.conf import settings as server_settings

from ctracker.models import SicknessNotification, UserPlaceRegister

TERMINATE = False
DEFAULT_INTERVAL = 30

logger = getLogger(__name__)


class Command(BaseCommand):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        signal.signal(signal.SIGINT, self.exit_gracefully)
        signal.signal(signal.SIGTERM, self.exit_gracefully)

    @staticmethod
    def exit_gracefully(sig, frame):
        logger.info("Exiting poll_unprocessed_notifications...")
        module = sys.modules[__name__]
        module.TERMINATE = True

    @staticmethod
    def sleep(seconds):
        module = sys.modules[__name__]
        for _ in range(seconds):
            if module.TERMINATE:
                break
            time.sleep(1)

    def add_arguments(self, parser):  # pragma: no cover
        parser.add_argument(
            "--loop",
            action="store_true",
            help="Continually restart command after a specified number of seconds.",
        )
        parser.add_argument(
            "--interval",
            "-i",
            type=int,
            help="The number of seconds to wait before restarting command. "
            "Defaults to {}.".format(DEFAULT_INTERVAL),
        )

    def handle(self, *_args, **options):  # pragma: no cover
        module = sys.modules[__name__]
        if options.get("loop"):
            while True:
                if module.TERMINATE:
                    break
                try:
                    self.poll_unprocessed_notifications()
                except InterfaceError as ie:
                    logger.exception("poll_unprocessed_notifications() error when connecting to database")
                    pass
                except Exception as e:
                    logger.exception("poll_unprocessed_notifications() from connector threw an unexpected exception")
                    pass
                self.sleep(options.get("interval") or DEFAULT_INTERVAL)
        else:
            self.poll_unprocessed_notifications()

    @staticmethod
    def poll_unprocessed_notifications():
        unprocessed_notifications: List[SicknessNotification] = (
            SicknessNotification.objects
            .select_related("user")
            .filter(is_processed=False)
            .order_by("created_at")
            .all()
        )

        for notification in unprocessed_notifications:
            logger.debug(f"Processing notification {notification}")
            x_days_ago = notification.created_at - timedelta(days=server_settings.DAYS_BEFORE_NOTIFICATION)
            places_user_has_been = UserPlaceRegister.objects.filter(
                user=notification.user,
                departure_date__gt=x_days_ago
            ).all()

            for place_user_has_been in places_user_has_been:
                before_time_window_qparams = Q(
                    departure_date__lt=place_user_has_been.arrival_date
                )
                after_time_window_qparams = Q(
                    arrival_date__gt=place_user_has_been.departure_date
                )
                registers_to_notify: List[UserPlaceRegister] = (
                    UserPlaceRegister.objects
                    .filter(place_id=place_user_has_been.place_id)
                    .exclude(
                        before_time_window_qparams |
                        after_time_window_qparams |
                        Q(user=notification.user) |
                        Q(has_to_notify=True)
                    )
                    .all()
                )
                for register in registers_to_notify:
                    logger.debug(f"Indicate that {register} needs to be notified")
                    register.number_of_notifications += 1
                    register.has_to_notify = True
                    register.save()

            logger.debug(f"Notification {notification} was processed")
            notification.is_processed = True
            notification.save()
