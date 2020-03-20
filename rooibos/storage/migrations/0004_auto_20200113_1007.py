# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('storage', '0003_auto_20190527_1050'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='media',
            name='master',
        ),
        migrations.AlterField(
            model_name='storage',
            name='credential_id',
            field=models.CharField(max_length=100, null=True, blank=True),
        ),
        migrations.AlterField(
            model_name='storage',
            name='credential_key',
            field=models.CharField(max_length=100, null=True, blank=True),
        ),
    ]
