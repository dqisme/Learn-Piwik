docker run --name lsc-piwik-test-site -p 3000:80 -v `pwd`/index.html:/usr/share/nginx/html/index.html:ro -d nginx
