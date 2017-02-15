
server {


    server_name example-no-cache.com   www.example-no-cache.com;


    access_log /var/log/nginx/example-no-cache.com.access.log rt_cache; 
    error_log /var/log/nginx/example-no-cache.com.error.log warn;


    root /var/www/example-no-cache.com/htdocs;
    
    

    index index.php index.html index.htm;


    include common/php.conf;      
    include common/wpcommon.conf;
    include common/locations.conf;
    include /var/www/example-no-cache.com/conf/nginx/*.conf;
}
