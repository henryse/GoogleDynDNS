#!/usr/bin/env bash
# /etc/init.d/dyn_dns

function log_message {
    echo $1;
    logger -p info $1;
}

if [ true != "$INIT_D_SCRIPT_SOURCED" ] ; then
    set "$0" "$@"; INIT_D_SCRIPT_SOURCED=true . /lib/init/init-d-script
fi

### BEGIN INIT INFO
# Provides:          dyn_dns
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: dyn_dns script
# Description:       Used to control the dyn_dns
### END INIT INFO

process_id=$(ps -ax | grep 'dyn_dns' | grep -v 'grep' | awk '{print $1}')

# The following part carries out specific functions depending on arguments.
case "$1" in
  start)
    log_message "Starting dyn_dns...";
    if [ -z "${process_id}" ]; then
        log_message "dyn_dns script executing";
        /bin/bash -c "cd /home/pi/GoogleDynDNS/;make daemon";
    else
        log_message "dyn_dns is already running: ${process_id}";
    fi
    ;;
  stop)
    log_message "Stopping dyn_dns...";

    if [ -z "${process_id}" ]; then
        log_message "dyn_dns is not running";
    else
        log_message "Killing ${process_id}";
        sudo kill ${process_id}
    fi
    ;;
  *)
    echo "Usage: /etc/init.d/dyn_dns {start|stop}"
    exit 1
    ;;
esac

exit 0

# Author: Samuel Kelly <samuel@2829applegate.biz>

DESC="dyn_dns"

# TODO: We need to fill this in....
DAEMON=/home/pi/GoogleDynDNS/dyn_dns.rb
