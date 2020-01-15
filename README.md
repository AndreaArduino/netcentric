# netcentric
Setup
Pull Docker image
docker pull andreaarduino/puppet-nginx:v5
Run Docker container
docker container run --name puppet-nginx -d -p 8080:8080 andreaarduino/puppet-nginx:v5

Testing

Redirects
docker container exec -it puppet-nginx bash
curl -H "Host: domain.com" -k https://localhost -vvv
curl -H "Host: domain.com" -k https://localhost/ -vvv
curl -H "Host: domain.com" -k https://localhost/resoure2 -vvv
curl -H "Host: domain.com" -k https://localhost/resoure2/ -vvv

Proxy
docker container exec -it puppet-nginx bash
tail -f /var/log/nginx/forward_proxy.access.log
Open Firefox -> open preferences -> General -> Network settings -> select "Manual proxy configuration" -> for HTTP Proxy use "localhost" and for its Port use "8080"
