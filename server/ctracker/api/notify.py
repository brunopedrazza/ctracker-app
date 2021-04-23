from django.core.exceptions import ObjectDoesNotExist
from rest_framework import status

from rest_framework.request import Request
from .utils import ApiResponse as Response, notify_sickness
from .models import NotifySickness
from rest_framework.decorators import api_view, renderer_classes
from rest_framework.renderers import JSONRenderer

from ..api.authorization import validate_api_key


@api_view(["POST"])
@renderer_classes([JSONRenderer])
@validate_api_key()
def post(request: Request) -> Response:
    try:
        data = request.data
        notification = NotifySickness(**data)
        notify_sickness(notification)
        return Response(None, status=status.HTTP_200_OK)
    except (RuntimeError, ValueError) as e:
        return Response(str(e), status=status.HTTP_400_BAD_REQUEST, success=False)
    except ObjectDoesNotExist as e:
        return Response(str(e), status=status.HTTP_404_NOT_FOUND, success=False)
    except KeyError as ke:
        return Response(f"{str(ke)} is required", status=status.HTTP_400_BAD_REQUEST, success=False)
    except Exception as e:
        return Response("internal server error", status=status.HTTP_500_INTERNAL_SERVER_ERROR, success=False)