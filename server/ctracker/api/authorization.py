from uuid import uuid4

import jwt
import time
import codecs

from typing import Optional, Union, Tuple

from rest_framework import status
from rest_framework.request import Request
from rest_framework.response import Response


from django.conf import settings as server_settings

from ctracker.api.utils import ApiResponse


def validate_token():
    """Decorator to validate the token in a request."""

    def decorator(view):
        def wrapper(request, *args, **kwargs):
            return _check_auth(request, view, *args, **kwargs)
        return wrapper

    return decorator


def _check_auth(
    request, func, *args, **kwargs
):
    try:
        _validate_jwt_request(request)
    except ValueError as e:
        return ApiResponse(str(e), status=status.HTTP_401_UNAUTHORIZED, success=False)
    return func(request, *args, **kwargs)


def _validate_jwt_request(request: Request):
    """
    Validate the JSON web token in a request

    :raises ValueError: invalid JWT
    """
    jwt_header = request.META.get("HTTP_AUTHORIZATION")
    if not jwt_header:
        raise ValueError("JWT must be passed as 'Authorization' header")
    bad_format_error = ValueError(
        "'Authorization' header must be formatted as 'Bearer <token>'"
    )
    if "Bearer" not in jwt_header:
        raise bad_format_error
    try:
        encoded_jwt = jwt_header.split(" ")[1]
    except IndexError:
        raise bad_format_error
    if not encoded_jwt:
        raise bad_format_error
    # Validate the JWT contents.
    try:
        tenant_id = server_settings.AZURE_TRANSFERO["TENANT_ID"]
        client_id = server_settings.AZURE_REGISTRATION["CLIENT_ID"]
        issuer = f"https://sts.windows.net/{tenant_id}/"
        # public_key = get_public_key(encoded_jwt, tenant_id)
        options = {
            "verify_signature": True,
            "verify_aud": True,
            "verify_iss": True,
            "verify_exp": True
        }
        jwt_dict = jwt.decode(
            encoded_jwt,
            public_key,
            algorithms=["RS256"],
            issuer=issuer,
            audience=client_id,
            options=options
        )
    except AttributeError as e:
        raise ValueError("Unable to decode jwt")
    # except InvalidAudienceError as e:
    #     raise ValueError("Invalid audience")
    # except InvalidIssuerError as e:
    #     raise ValueError("Invalid issuer")
