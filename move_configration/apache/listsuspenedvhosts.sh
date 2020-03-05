#!/bin/bash

find /etc/httpd/conf.d/vhosts/*.sus 2>/dev/null | awk 'BEGIN {FS="/"}{print $6}' | awk 'BEGIN {FS="."}{print $2"."$3"."$4}'
