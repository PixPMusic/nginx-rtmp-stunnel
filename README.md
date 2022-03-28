Built this so I could have rtmp restreaming + rtmps restreaming via nginx

Used to build against linuxserver/letsencrypt (now linuxserver/swag) but I no longer need certbot

This personally only ever gets used to push/pull streams, never to serve HTTP content

First run will exit after files are generated. This is expected. nginx doesn't have a conf file yet so it dies.

Edit the files in /config to your liking, then start the container

rtmp push can be added directly to nginx.conf, but rtmps requires passing through stunnel. see /config/stunnel/conf.d and nginx.conf for my Telegram example, but essentially, give stunnel the host, then put the path on the end of the local proxy

Example docker-compose.yml provided. I don't use docker run/create anymore so you'll need to figure that out

Don't expose stunnel ports, just nginx ones.

Credits:

[alfg/docker-nginx-rtmp](https://github.com/alfg/docker-nginx-rtmp) Based my container off their Dockerfile, but with the sergey-dryabzhinsky fork of nginx-rtmp. Also, optimized the build steps a bit for faster deploys.

[nginx-rtmp-module updated](https://github.com/sergey-dryabzhinsky/nginx-rtmp-module) this one has support for dynamic loading and is just generally newer code  

[original nginx-rtmp-module](https://github.com/arut/nginx-rtmp-module) These guys deserve some love too.  
