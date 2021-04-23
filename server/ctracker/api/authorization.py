from rest_framework import status
from rest_framework.request import Request

from django.conf import settings as server_settings

from ctracker.api.utils import ApiResponse


def validate_api_key():
    """Decorator to validate the api-key in a request."""

    def decorator(view):
        def wrapper(request, *args, **kwargs):
            return _check_auth(request, view, *args, **kwargs)
        return wrapper

    return decorator


def _check_auth(
    request, func, *args, **kwargs
):
    try:
        _validate_api_key_request(request)
    except ValueError as e:
        return ApiResponse(str(e), status=status.HTTP_401_UNAUTHORIZED, success=False)
    return func(request, *args, **kwargs)


def _validate_api_key_request(request: Request):
    api_key_header = request.META.get("HTTP_X_API_KEY")
    if not api_key_header:
        raise ValueError("Api Key must be passed as 'X-API-KEY' header")
    if api_key_header != server_settings.SERVER_API_KEY:
        raise ValueError("Invalid 'api-key'")
