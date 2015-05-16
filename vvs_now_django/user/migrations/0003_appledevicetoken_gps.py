# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0002_appledevicetoken_usergpslocation'),
    ]

    operations = [
        migrations.AddField(
            model_name='appledevicetoken',
            name='gps',
            field=models.ForeignKey(to='user.UserGPSLocation', default=1),
            preserve_default=False,
        ),
    ]
