from django.urls import path
from ctracker.api.controllers import placecontroller, notificationcontroller, usercontroller

urlpatterns = [
    path("user/login", usercontroller.login),
    path("user/register", usercontroller.register),
    path("user/update/<email>", usercontroller.update),
    path("user/<email>", usercontroller.get),
    path("place/register", placecontroller.register),
    path("place/user/<user_email>", placecontroller.get_places),
    path("notification", notificationcontroller.post_notification),
]