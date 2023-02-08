#!/bin/sh
# setup http proxy for sudo
cat <<EOF >> /etc/sudoers
Defaults  env_keep +="http_proxy" 
Defaults  env_keep +="https_proxy"
Defaults  env_keep +="HTTP_PROXY"
Defaults  env_keep +="HTTPS_PROXY"
EOF
