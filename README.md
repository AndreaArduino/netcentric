# Netcentric - technical assessment

## Useful links

### GitHub repository

https://github.com/AndreaArduino/netcentric

### Docker Hub repository

https://hub.docker.com/repository/docker/andreaarduino/puppet-nginx

## How the Puppet module for Nginx web server works

The Puppet module for Nginx web server is deployed within a Docker container.
The Docker container has the following features:
* **base image**: CentOs 7 latest version
* **installed packages**: Puppet - latest version
* **existing Puppet module installed**: jfryman-nginx

### jfryman-nginx Puppet module customizations
* **puppet/nginx.pp** - install Nginx web server
* **puppet/nginx_redirect.pp** - implement Nginx redirects for domain.com
* **puppet/nginx_proxy.pp** - implement forward proxy within Nginx with custom log format

## Setup for testing

### Introduction

The instructions provided in the following section will allow the user to run the Docker container previously described.

The user will connect via SSH to the Docker container in order to test Nginx redirects behaviour.

The user will also be guided through the configuration of a common web browser in order to exploit the Docker container as a forward proxy.

### Requirements

1. Docker installed on the local machine where tests are conducted. Please see [Docker install page](https://docs.docker.com/install/) for installation details.
2. Mozilla Firefox installed on the local machine
3. Internet connection

### Pull Docker image

Pull latest Docker image from [Docker Hub repository](https://hub.docker.com/repository/docker/andreaarduino/puppet-nginx):

```
docker pull andreaarduino/puppet-nginx:latest
```

### Run Docker container

Run Docker container from the previously pulled image and map port 8080 of your local machine over port 8080 of the Docker container:

```
docker container run --name puppet-nginx -d -p 8080:8080 andreaarduino/puppet-nginx:latest
```

## Testing

### Redirects

Run a shell on the Docker container:

```
docker container exec -it puppet-nginx bash
```

Execute the `curl` commands below within the Docker container and look for *Location* in the output of each command in order to verify that the redirects are properly working:

```
curl -H "Host: domain.com" -k https://localhost -vvv
```

```
curl -H "Host: domain.com" -k https://localhost/ -vvv
```

```
curl -H "Host: domain.com" -k https://localhost/resoure2 -vvv
```

```
curl -H "Host: domain.com" -k https://localhost/resoure2/ -vvv
```

### Proxy

Web browser configuration:
* **Mozilla Firefox**: open Mozilla Firefox on your local machine -> navigate to "about:preferences" -> go to General -> Network settings -> select "Manual proxy configuration" -> for **HTTP Proxy** use `localhost` and for its **Port** use `8080`

Navigate any site using http protocol - e.g., http://google.com

Run a shell on the Docker container:

```
docker container exec -it puppet-nginx bash
```

Check latest lines of the Nginx logs in order to see the traffic flowing through the proxy:

```
tail -50f /var/log/nginx/forward_proxy.access.log
```

