upstream biwork {
        ip_hash;
        server 127.0.0.11:8888 fail_timeout=5580s max_fails=1000;
}

server {
    if ($host = staging.bi.work.cl) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name staging.bi.work.cl;
    server_tokens off;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }


}



server {
        listen 443 ssl;
        server_name staging.bi.work.cl;
        # Use certificate and key provided by Let's Encrypt:
    ssl_certificate /etc/letsencrypt/live/staging.bi.work.cl/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/staging.bi.work.cl/privkey.pem; # managed by Certbot

    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

	access_log /var/log/nginx/work-https.log;
	error_log /var/log/nginx/work-https.error.log warn;
        
	location / {
                proxy_read_timeout 210;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-NginX-Proxy true;
                proxy_pass http://biwork;
                proxy_ssl_session_reuse off;
                proxy_set_header Host $http_host;
                proxy_cache_bypass $http_upgrade;
                proxy_redirect off;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
		# proxy_send_timeout 180s;
		# proxy_read_timeout 180s;
        }
        
	location /nginx_status {
                stub_status on;
        }

}


