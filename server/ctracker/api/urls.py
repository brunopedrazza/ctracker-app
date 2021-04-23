from django.urls import path
from ..api import user

urlpatterns = [
    path("user/login", user.login),
    path("user/register", user.register),
    path("user/update/<email>", user.update),
    path("user/<email>", user.get),
]