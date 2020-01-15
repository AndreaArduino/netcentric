FROM centos:centos7
RUN yum install vim -y && rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm && yum install puppet -y && puppet resource package puppet ensure=latest
RUN mkdir -p /etc/puppet/manifests
ADD puppet/ /etc/puppet/manifests/
RUN puppet module install jfryman-nginx
VOLUME /etc/puppet
RUN puppet apply /etc/puppet/manifests/nginx.pp && puppet apply /etc/puppet/manifests/nginx_proxy.pp && puppet apply /etc/puppet/manifests/nginx_redirect.pp
ADD ssl_config/ssl_input.txt /etc/pki/tls/
CMD /usr/bin/openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/pki/tls/private/domain_com.key -out /etc/pki/tls/certs/domain_com.crt < /etc/pki/tls/ssl_input.txt && nginx -g 'daemon off;'
