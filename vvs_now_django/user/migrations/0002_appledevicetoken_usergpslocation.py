# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='AppleDeviceToken',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, primary_key=True, auto_created=True)),
                ('token', models.CharField(max_length=64, unique=True)),
                ('user', models.ForeignKey(to='user.User')),
            ],
        ),
        migrations.CreateModel(
            name='UserGPSLocation',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, primary_key=True, auto_created=True)),
                ('latitude', models.FloatField(null=True)),
                ('longitude', models.FloatField(null=True)),
                ('last_update', models.DateTimeField(auto_now=True)),
                ('user', models.ForeignKey(to='user.User')),
            ],
        ),
    ]
