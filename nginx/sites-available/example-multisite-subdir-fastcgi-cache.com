
server {

    # Uncomment the following line for domain mapping
    # listen 80 default_server;

    server_name example-multisite-subdir-fastcgi-cache.com   *.example-multisite-subdir-fastcgi-cache.com;

    # Uncomment the following line for domain mapping
    #server_name_in_redirect off;

    access_log /var/log/nginx/example-multisite-subdir-fastcgi-cache.com.access.log rt_cache; 
    error_log /var/log/nginx/example-multisite-subdir-fastcgi-cache.com.error.log warn;


    root /var/www/example-multisite-subdir-fastcgi-cache.com/htdocs;
    
    

    index index.php index.html index.htm;


    include common/wpfc.conf;      include common/wpsubdir.conf;
    include common/wpcommon.conf;
    include common/locations.conf;
    include /var/www/example-multisite-subdir-fastcgi-cache.com/conf/nginx/*.conf;
}
