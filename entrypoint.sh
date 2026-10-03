#!/bin/sh
/run.sh
echo "0 */6 * * * /run.sh > /proc/1/fd/1 2>&1" > /var/spool/cron/crontabs/root
exec crond -f -l 2
