# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0001_initial'),
        ('route', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='route',
            name='user',
            field=models.ForeignKey(to='user.User', default=1),
            preserve_default=False,
        ),
    ]
