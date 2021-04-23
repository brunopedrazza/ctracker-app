import re
from datetime import datetime

email_regex = r'^(\w|\.|\_|\-)+[@](\w|\_|\-|\.)+[.]\w{2,3}$'


def is_invalid_email(email: str) -> bool:
    return not re.match(email_regex, email)


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
        self.last_name = kwargs["last_name"]
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
        self.last_name = kwargs["last_name"]
        self.birthdate = datetime.strptime(kwargs["birthdate"], "%d/%m/%Y")
        if self.birthdate > datetime.now():
            raise RuntimeError("invalid birthdate")
