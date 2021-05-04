from uuid import uuid4

from django.db import models
from django.core.validators import MinLengthValidator


class User(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid4, editable=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    first_name = models.CharField(max_length=254)
    last_name = models.CharField(max_length=254)
    birthdate = models.DateField(auto_now=False, auto_now_add=False)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=128, validators=[MinLengthValidator(128)])

    notification_enabled = models.BooleanField(default=True)

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
            "email": self.email,
            "notification_enabled": self.notification_enabled
        }


class UserPlaceRegister(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid4, editable=False)
    created_at = models.DateTimeField(auto_now_add=True)
    has_to_notify = models.BooleanField(default=False)

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    arrival_date = models.DateTimeField(auto_now=False, auto_now_add=False)
    departure_date = models.DateTimeField(auto_now=False, auto_now_add=False)
    place_id = models.TextField()
    number_of_notifications = models.IntegerField(default=0)

    class Meta:
        app_label = "ctracker"
        unique_together = ["user", "place_id", "arrival_date"]

    def __str__(self):
        return f"{self.user.name} ({self.place_id})"

    def to_dict(self):
        return {
            "arrival_date": self.arrival_date,
            "departure_date": self.departure_date,
            "place_id": self.place_id,
            "number_of_notifications": self.number_of_notifications
        }


class SicknessNotification(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid4, editable=False)
    created_at = models.DateTimeField(auto_now_add=True)

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    symptoms = models.TextField(null=True, blank=True)
    is_processed = models.BooleanField(default=False)

    class Meta:
        app_label = "ctracker"

    def __str__(self):
        return f"{self.user.name} ({self.is_processed})"
