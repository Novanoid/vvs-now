from django.shortcuts import render

# Create your views here.
from rest_framework import viewsets
from .serializer import RouteSerializer, LineSerializer
from .models import Route, Line, Task
from user.models import UserGPSLocation, AppleDeviceToken
from .tasks import calculate_route
# Create your views here.
import datetime
from django.http import HttpResponse
from user.models import User

class RouteViewSet(viewsets.ModelViewSet):
    queryset = Route.objects.all()
    serializer_class = RouteSerializer


class LineViewSet(viewsets.ModelViewSet):
    queryset = Line.objects.all()
    serializer_class = LineSerializer


def create_task(request, user_id, destination, time):
    time, rest = time.split(".")
    time = datetime.datetime.utcfromtimestamp(int(time))
    task = Task(time=time, destination=destination, user_id=user_id)
    task.save()
    calculate_route.apply_async(args=[task], countdown=10)
    # TODO celery schedule task
    return HttpResponse("Im never gona give you up let you done ....")


def update_gps(request, user_id, lat, long):
    user = User.objects.get(pk=user_id)
    gps, created = UserGPSLocation.objects.get_or_create(user=user)
    gps.latitude = lat
    gps.longitude = long
    gps.save()
    return HttpResponse("Im never gona give you up let you done ....")


def create_toke(request, user_id, token):
    user = User.objects.get(pk=user_id)
    gps = UserGPSLocation.objects.get(user=user)
    token = AppleDeviceToken(user=user, token=token, gps=gps)
    token.save()
    return HttpResponse("Im never gona give you up let you done ....")