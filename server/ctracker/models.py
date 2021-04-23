import datetime
from uuid import uuid4

from django.db import models
from django.core.validators import MinLengthValidator


def utc_now():
    return datetime.datetime.now(datetime.timezone.utc)


class User(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid4, editable=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    first_name = models.CharField(max_length=254)
    last_name = models.CharField(max_length=254)
    birthdate = models.DateField(auto_now=False, auto_now_add=False)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=128, validators=[MinLengthValidator(128)])

    objects = models.Manager()

    @property
    def name(self):
        return " ".join([str(self.first_name), str(self.last_name)])

    class Meta:
        app_label = "ctracker"

    def __str__(self):
        return f"{self.name} ({self.email})"

    def to_dict(self):
        return {
            "first_name": self.first_name,
            "last_name": self.last_name,
            "birthdate": self.birthdate.strftime("%d/%m/%Y"),
            "email": self.email
        }

