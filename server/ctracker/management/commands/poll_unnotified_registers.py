import sys
import signal
import time
from logging import getLogger

from typing import List

from django.core.management import BaseCommand
from django.db.utils import InterfaceError

from ctracker.models import SicknessNotification, UserPlaceRegister

TERMINATE = False
DEFAULT_INTERVAL = 60

logger = getLogger(__name__)


class Command(BaseCommand):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        signal.signal(signal.SIGINT, self.exit_gracefully)
        signal.signal(signal.SIGTERM, self.exit_gracefully)

    @staticmethod
    def exit_gracefully(sig, frame):
        logger.info("Exiting poll_unnotified_registers...")
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
                    self.poll_unnotified_registers()
                except InterfaceError as ie:
                    logger.exception("poll_unnotified_registers() error when connecting to database")
                    pass
                except Exception as e:
                    # This is very likely a bug, so re-raise the error and crash.
                    # Heroku will restart the process unless it is repeatedly crashing,
                    # in which case restarting isn't of much use.
                    logger.exception("poll_unnotified_registers() from connector threw an unexpected exception")
                    pass
                self.sleep(options.get("interval") or DEFAULT_INTERVAL)
        else:
            self.poll_unnotified_registers()

    @staticmethod
    def poll_unnotified_registers():
        unnotified_registers: List[UserPlaceRegister] = (
            UserPlaceRegister.objects
            .select_related("user")
            .filter(has_to_notify=True)
            .all()
        )

        # TODO: Send this registers to frontend in order to notify users

        for register in unnotified_registers:
            logger.info(f"Place register {register} was notified")
            register.has_to_notify = False
            register.save()
