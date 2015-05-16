# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0002_appledevicetoken_usergpslocation'),
        ('route', '0002_route_user'),
    ]

    operations = [
        migrations.CreateModel(
            name='Task',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, primary_key=True, auto_created=True)),
                ('destination', models.IntegerField()),
                ('time', models.DateTimeField()),
                ('user', models.ForeignKey(to='user.User')),
            ],
        ),
    ]
