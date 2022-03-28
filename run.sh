#!/bin/sh
if [ ! -f "/config/stunnel/stunnel.conf" ]; then
    mkdir -p /config/stunnel/conf.d
    cat <<EOF > /config/stunnel/stunnel.conf
include = /etc/stunnel/conf.d
EOF

    cat <<EOF > /config/stunnel/conf.d/telegram.conf
[telegram]
client = yes
accept = 127.0.0.1:19350
connect = dc1-1.rtmp.t.me:443
verifyChain = no
EOF
fi

if [ ! -f "/config/nginx/nginx.conf" ]; then
    mkdir -p /config/nginx
    cat <<EOF > /config/nginx/nginx.conf
user nobody users;
daemon off;
error_log /dev/stdout info;

events {
    worker_connections 1024;
}

rtmp {
    server {
        listen 1935;
        chunk_size 4096;

        application live {
            live on;
            # Telegram
            # push rtmp://localhost:19350/s/telegram-stream-key; # Telegram via stunnel
            # make sure to check the server in config/stunnel/conf.d/telegram.conf vs your stream server
        }
    }
}
EOF
fi

cp -r /config/stunnel/* /etc/stunnel/
cp -r /config/nginx/nginx.conf /etc/nginx/nginx.conf

exec /usr/bin/stunnel /etc/stunnel/stunnel.conf
