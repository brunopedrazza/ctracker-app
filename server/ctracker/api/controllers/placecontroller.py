from django.core.exceptions import ObjectDoesNotExist
from rest_framework import status

from rest_framework.request import Request
from ctracker.api.utils import ApiResponse as Response, register_user_place, get_place_registrations
from ctracker.api.models import UserPlaceRegisterModel
from rest_framework.decorators import api_view, renderer_classes
from rest_framework.renderers import JSONRenderer

from ctracker.api.authorization import validate_api_key


@api_view(["POST"])
@renderer_classes([JSONRenderer])
@validate_api_key()
def register(request: Request) -> Response:
    try:
        data = request.data
        user_place = UserPlaceRegisterModel(**data)
        register_user_place(user_place)
        return Response(None, status=status.HTTP_200_OK)
    except (RuntimeError, ValueError) as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST, success=False)
    except ObjectDoesNotExist as e:
        return Response(str(e), status=status.HTTP_404_NOT_FOUND, success=False)
    except KeyError as ke:
        return Response(f"{str(ke)} is required", status=status.HTTP_400_BAD_REQUEST, success=False)
    except Exception as e:
        return Response("internal server error", status=status.HTTP_500_INTERNAL_SERVER_ERROR, success=False)


@api_view(["GET"])
@renderer_classes([JSONRenderer])
@validate_api_key()
def get_places(request: Request, user_email: str) -> Response:
    try:
        registrations = get_place_registrations(user_email)
        return Response(registrations, status=status.HTTP_200_OK)
    except (RuntimeError, ValueError) as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST, success=False)
    except ObjectDoesNotExist as e:
        return Response(str(e), status=status.HTTP_404_NOT_FOUND, success=False)
    except KeyError as ke:
        return Response(f"{str(ke)} is required", status=status.HTTP_400_BAD_REQUEST, success=False)
    except Exception as e:
        return Response("internal server error", status=status.HTTP_500_INTERNAL_SERVER_ERROR, success=False)
