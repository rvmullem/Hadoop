for server in `grep -v ^# testservers`; do   echo $server;   ssh -t $server "$@"; done
