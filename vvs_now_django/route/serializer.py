__author__ = 'fritz'
from .models import Route, Line
from rest_framework import serializers


class RouteSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Route
        fields = ('pk', 'start_time', 'end_time', 'lines', 'user')


class LineSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Line
        fields = ('pk',
                  'start_time',
                  'end_time',
                  'start_point_id',
                  'end_point_id',
                  'vehicle')