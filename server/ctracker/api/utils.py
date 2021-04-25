from typing import List, Dict

from django.db import IntegrityError
from rest_framework.response import Response

from ctracker.api.models import UserRegister, UserUpdate, UserPlaceRegisterModel, NotifySickness
from ctracker.models import User, UserPlaceRegister, SicknessNotification


class ApiResponse(Response):
    def __init__(self, result, status: str, success: bool = True):
        if not success:
            result = {"error": result}
        super().__init__(result, status)


def get_user(email: str) -> User:
    return User.objects.get(email__exact=email)


def authenticate_user(email: str, password: str) -> User:
    user = get_user(email)
    if user.password != password:
        raise ValueError("invalid password")
    return user


def register_user(registration: UserRegister):
    try:
        User.objects.create(**registration.__dict__)
    except IntegrityError as e:
        raise ValueError("user is already registered")


def update_user(user_update: UserUpdate, email: str) -> User:
    user = get_user(email)
    user.first_name = user_update.first_name
    user.last_name = user_update.last_name
    user.birthdate = user_update.birthdate
    user.save()
    user.refresh_from_db()
    return user


def register_user_place(user_place_register: UserPlaceRegisterModel):
    user = get_user(user_place_register.user_email)
    try:
        UserPlaceRegister.objects.create(
            user=user,
            arrival_date=user_place_register.arrival_date,
            departure_date=user_place_register.departure_date,
            place_id=user_place_register.place_id
        )
    except IntegrityError as e:
        raise ValueError("user place is already registered")


def get_place_registrations(user_email: str):
    user = get_user(user_email)
    registrations = (
        UserPlaceRegister.objects
        .filter(user=user)
        .order_by("-created_at")
        .all()
    )
    return [pr.to_dict() for pr in registrations or []]


def notify_sickness(notification: NotifySickness):
    user = get_user(notification.user_email)
    if not user.notification_enabled:
        raise ValueError("user has notifications disabled")
    try:
        SicknessNotification.objects.create(
            user=user,
            symptoms=notification.symptoms,
        )
    except IntegrityError as e:
        raise ValueError("notification is already registered")
    user.notification_enabled = False
    user.save()
