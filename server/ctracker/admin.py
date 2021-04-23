from django.contrib import admin
from ctracker.models import User, UserPlaceRegister, SicknessNotification


class UserAdmin(admin.ModelAdmin):
    """
    This defines the admin view of a User.
    """

    list_display = (
        "id",
        "email",
        "name",
        "birthdate",
        "notification_enabled",
        "password",
        "created_at"
    )


class UserPlaceRegisterAdmin(admin.ModelAdmin):
    """
    This defines the admin view of a UserPlaceRegister.
    """

    list_display = (
        "id",
        "user_email",
        "arrival_date",
        "departure_date",
        "place_id",
        "has_to_notify",
        "created_at",
    )

    def user_email(self, obj):
        return obj.user.email

    user_email.short_description = "User Email"


class SicknessNotificationAdmin(admin.ModelAdmin):
    """
    This defines the admin view of an SicknessNotification.
    """

    list_display = (
        "id",
        "user_email",
        "symptoms",
        "is_processed",
    )

    def user_email(self, obj):
        return obj.user.email

    user_email.short_description = "User Email"


admin.site.register(User, UserAdmin)
admin.site.register(UserPlaceRegister, UserPlaceRegisterAdmin)
admin.site.register(SicknessNotification, SicknessNotificationAdmin)
