from rest_framework import status

from ctracker.api.utils import ApiResponse as Response, authenticate_user, register_user, update_user, get_user
from ctracker.api.models import UserLogin, UserRegister, UserUpdate

from rest_framework.request import Request
from rest_framework.decorators import api_view, renderer_classes
from rest_framework.renderers import JSONRenderer

from django.core.exceptions import ObjectDoesNotExist

from ctracker.api.authorization import validate_api_key


@api_view(["POST"])
@renderer_classes([JSONRenderer])
@validate_api_key()
def login(request: Request) -> Response:
    try:
        data = request.data
        user_login = UserLogin(**data)
        user = authenticate_user(user_login.email, user_login.password)
        return Response(user.to_dict(), status=status.HTTP_200_OK)
    except (RuntimeError, ValueError) as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST, success=False)
    except ObjectDoesNotExist as e:
        return Response(str(e), status=status.HTTP_404_NOT_FOUND, success=False)
    except KeyError as ke:
        return Response(f"{str(ke)} is required", status=status.HTTP_400_BAD_REQUEST, success=False)
    except Exception as e:
        return Response("internal server error", status=status.HTTP_500_INTERNAL_SERVER_ERROR, success=False)


@api_view(["POST"])
@renderer_classes([JSONRenderer])
@validate_api_key()
def register(request: Request) -> Response:
    try:
        data = request.data
        registration = UserRegister(**data)
        register_user(registration)
        return Response(None, status=status.HTTP_201_CREATED)
    except (RuntimeError, ValueError) as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST, success=False)
    except KeyError as ke:
        return Response(f"{str(ke)} is required", status=status.HTTP_400_BAD_REQUEST, success=False)
    except Exception as e:
        return Response("internal server error", status=status.HTTP_500_INTERNAL_SERVER_ERROR, success=False)


@api_view(["POST"])
@renderer_classes([JSONRenderer])
@validate_api_key()
def update(request: Request, email: str) -> Response:
    try:
        data = request.data
        user_update = UserUpdate(**data)
        updated_user = update_user(user_update, email)
        return Response(updated_user.to_dict(), status=status.HTTP_200_OK)
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
def get(request: Request, email: str) -> Response:
    try:
        user = get_user(email)
        return Response(user.to_dict(), status=status.HTTP_200_OK)
    except (RuntimeError, ValueError) as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST, success=False)
    except ObjectDoesNotExist as e:
        return Response(str(e), status=status.HTTP_404_NOT_FOUND, success=False)
    except KeyError as ke:
        return Response(f"{str(ke)} is required", status=status.HTTP_400_BAD_REQUEST, success=False)
    except Exception as e:
        return Response("internal server error", status=status.HTTP_500_INTERNAL_SERVER_ERROR, success=False)
