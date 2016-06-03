#!/bin/sh
set -xe

(rm -Rf app/cache/* && rm -Rf app/logs/*) || true
sleep 1
(chown www-data:www-data . && chown -R www-data:www-data app/cache app/logs web/) || true
(rm -Rf app/cache/* && rm -Rf app/logs/*) || true
