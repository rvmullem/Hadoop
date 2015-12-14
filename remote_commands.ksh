for server in `grep -v ^# testservers`; do   echo $server;  cat remote_commands |ssh -t $server -t -t sudo bash; done
