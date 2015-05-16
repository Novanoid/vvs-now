from django.db import models
from user.models import User
# Create your models here.


class Route(models.Model):
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    lines = models.ManyToManyField("Line")
    user = models.ForeignKey('user.User')


class Line(models.Model):
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    start_point_id = models.IntegerField()
    end_point_id = models.IntegerField()
    vehicle = models.IntegerField()


class Task(models.Model):
    user = models.ForeignKey('user.User')
    destination = models.IntegerField()
    time = models.DateTimeField()