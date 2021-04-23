from datetime import datetime

from django.db import IntegrityError
from rest_framework.response import Response

from ctracker.api.models import UserRegister, UserUpdate
from ctracker.models import User


class ApiResponse(Response):
    def __init__(self, result, status: str, success: bool = True):
        if not success:
            result = {"error": result}
        super().__init__(result, status)


def authenticate_user(email: str, password: str) -> User:
    user = User.objects.filter(email__exact=email).first()
    if not user:
        raise ValueError("user is not registered")
    if user.password != password:
        raise RuntimeError("invalid password")
    return user


def register_user(registration: UserRegister):
    try:
        User.objects.create(**registration.__dict__)
    except IntegrityError as e:
        raise ValueError("user is already registered")


def update_user(user_update: UserUpdate, email: str) -> User:
    user = User.objects.filter(email__exact=email).first()
    if not user:
        raise ValueError("user is not registered")
    user.first_name = user_update.first_name
    user.last_name = user_update.last_name
    user.birthdate = user_update.birthdate
    user.save()
    user.refresh_from_db()
    return user


def get_user(email: str) -> User:
    user = User.objects.filter(email__exact=email).first()
    if not user:
        raise ValueError("user is not registered")
    return user
