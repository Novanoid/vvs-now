from django.shortcuts import render

# Create your views here.
from rest_framework import viewsets
from .serializer import RouteSerializer, LineSerializer
from .models import Route, Line
# Create your views here.


class RouteViewSet(viewsets.ModelViewSet):
    queryset = Route.objects.all()
    serializer_class = RouteSerializer


class LineViewSet(viewsets.ModelViewSet):
    queryset = Line.objects.all()
    serializer_class = LineSerializer