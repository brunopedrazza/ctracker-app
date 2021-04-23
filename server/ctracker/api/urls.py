from django.urls import path
from ..api import user, place, notify

urlpatterns = [
    path("user/login", user.login),
    path("user/register", user.register),
    path("user/update/<email>", user.update),
    path("user/<email>", user.get),
    path("place/register", place.register),
    path("notify", notify.post),
]