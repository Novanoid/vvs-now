from django.db import models
from django.contrib.auth.models import AbstractUser, AbstractBaseUser, PermissionsMixin, UserManager
# Create your models here.


class User(AbstractBaseUser):
    username = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    first_name = models.CharField(max_length=100)
    email = models.EmailField()
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['email']

    def get_full_name(self):
        return "{} {}".format(self.first_name, self.last_name)

    def get_short_name(self):
        return self.first_name

    def __str__(self):
        return "id: {}".format(self.pk)


class AppleDeviceToken(models.Model):
    user = models.ForeignKey('User')
    token = models.CharField(max_length=64, unique=True)
    gps = models.ForeignKey("UserGPSLocation")


class UserGPSLocation(models.Model):
    user = models.ForeignKey("User")
    latitude = models.FloatField(null=True)
    longitude = models.FloatField(null=True)
    last_update = models.DateTimeField(auto_now=True)