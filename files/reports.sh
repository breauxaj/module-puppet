#!/bin/sh
find /var/lib/puppet/reports -type f -name \*.yaml -mtime +1 -exec rm -f {} \;