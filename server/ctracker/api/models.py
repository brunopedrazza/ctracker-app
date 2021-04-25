import re
from datetime import datetime, timezone

email_regex = r'^(\w|\.|\_|\-)+[@](\w|\_|\-|\.)+[.]\w{2,3}$'


def is_invalid_email(email: str) -> bool:
    return not re.match(email_regex, email)


def utc_now():
    return datetime.now(timezone.utc)


class UserLogin(object):
    def __init__(self, *args, **kwargs):
        self.email = kwargs["email"]
        if is_invalid_email(self.email):
            raise RuntimeError("email is invalid")
        self.password = kwargs["password"]
        if len(self.password) != 128:
            raise RuntimeError("password with incorrect length")


class UserRegister(object):
    def __init__(self, *args, **kwargs):
        self.first_name = kwargs["first_name"]
        if not self.first_name:
            raise RuntimeError("first name cannot be empty")
        self.last_name = kwargs["last_name"]
        if not self.last_name:
            raise RuntimeError("last name cannot be empty")
        self.birthdate = datetime.strptime(kwargs["birthdate"], "%d/%m/%Y")
        if self.birthdate > datetime.now():
            raise RuntimeError("invalid birthdate")
        self.email = kwargs["email"]
        if is_invalid_email(self.email):
            raise RuntimeError("email is invalid")
        self.password = kwargs["password"]
        if len(self.password) != 128:
            raise RuntimeError("password with incorrect length")


class UserUpdate(object):
    def __init__(self, *args, **kwargs):
        self.first_name = kwargs["first_name"]
        if not self.first_name:
            raise RuntimeError("first name cannot be empty")
        self.last_name = kwargs["last_name"]
        if not self.last_name:
            raise RuntimeError("last name cannot be empty")
        self.birthdate = datetime.strptime(kwargs["birthdate"], "%d/%m/%Y")
        if self.birthdate > utc_now():
            raise RuntimeError("invalid birthdate")


class UserPlaceRegisterModel(object):
    def __init__(self, *args, **kwargs):
        self.user_email = kwargs["user_email"]
        if not self.user_email:
            raise RuntimeError("user email cannot be empty")
        self.arrival_date = datetime.strptime(kwargs["arrival_date"], "%d/%m/%Y %H:%M").astimezone(timezone.utc)
        self.departure_date = datetime.strptime(kwargs["departure_date"], "%d/%m/%Y %H:%M").astimezone(timezone.utc)
        now = utc_now()
        if self.arrival_date > now:
            raise RuntimeError("invalid arrival_date")
        if self.departure_date > now:
            raise RuntimeError("invalid departure_date")
        if self.arrival_date >= self.departure_date:
            raise RuntimeError("arrival_date cannot be higher than departure_date")
        self.place_id = kwargs["place_id"]
        if not self.place_id:
            raise RuntimeError("place id cannot be empty")


class NotifySickness(object):
    def __init__(self, *args, **kwargs):
        self.user_email = kwargs["user_email"]
        if not self.user_email:
            raise RuntimeError("user email cannot be empty")
        self.symptoms = kwargs["symptoms"]
