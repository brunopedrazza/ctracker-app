import sys
import signal
import time
from datetime import datetime, timedelta, timezone
from logging import getLogger

from django.core.exceptions import ObjectDoesNotExist
from django.core.management import BaseCommand
from django.db.utils import InterfaceError

from django.conf import settings as server_settings

from ctracker.models import SicknessNotification, User

TERMINATE = False
DEFAULT_INTERVAL = 60

logger = getLogger(__name__)


def utc_now():
    return datetime.now(timezone.utc)


class Command(BaseCommand):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        signal.signal(signal.SIGINT, self.exit_gracefully)
        signal.signal(signal.SIGTERM, self.exit_gracefully)

    @staticmethod
    def exit_gracefully(sig, frame):
        logger.info("Exiting check_enable_notification...")
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
                    self.check_enable_notification()
                except InterfaceError as ie:
                    logger.exception("check_enable_notification() error when connecting to database")
                    pass
                except Exception as e:
                    # This is very likely a bug, so re-raise the error and crash.
                    # Heroku will restart the process unless it is repeatedly crashing,
                    # in which case restarting isn't of much use.
                    logger.exception("check_enable_notification() from connector threw an unexpected exception")
                    pass
                self.sleep(options.get("interval") or DEFAULT_INTERVAL)
        else:
            self.check_enable_notification()

    @staticmethod
    def check_enable_notification():
        now = utc_now()
        x_days_ago = now - timedelta(days=server_settings.DAYS_TO_LIMIT_NOTIFICATION)

        users_notification_disabled = User.objects.exclude(notification_enabled=True).all()
        for user in users_notification_disabled:
            try:
                SicknessNotification.objects.get(user=user, created_at__gte=x_days_ago)
            except ObjectDoesNotExist:
                logger.info(f"Enabling notification from user {user}")
                user.notification_enabled = True
                user.save()
