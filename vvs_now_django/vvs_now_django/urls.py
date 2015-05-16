"""vvs_now_django URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an import:  from blog import urls as blog_urls
    2. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from django.conf.urls import include, url
from django.contrib import admin
from rest_framework import routers
from user.views import UserViewSet
from route.views import create_task, update_gps, create_toke
from route.views import LineViewSet, RouteViewSet


# Routers provide an easy way of automatically determining the URL conf.
router = routers.DefaultRouter()
router.register(r'users', UserViewSet)


urlpatterns = [
    url(r'^tasks/(?P<user_id>[0-9]+)/Optional\((?P<destination>[0-9]+)\)/Optional\((?P<time>[0-9]+)\)/', create_task),
    url(r'^gps/(?P<user_id>[0-9]+)/(?P<lat>[0-9.]+)/(?P<long>[0-9.]+)/', update_gps),
    url(r'^token/(?P<user_id>[0-9]+)/(?P<token>)[\d\w]+/', create_toke),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]
