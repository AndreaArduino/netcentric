FROM centos:centos7
RUN yum install vim -y
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN yum install puppet -y
RUN puppet resource package puppet ensure=latest
RUN mkdir -p /etc/puppet/manifests
ADD puppet/nginx.pp /etc/puppet/manifests/
ADD puppet/nginx_proxy.pp /etc/puppet/manifests/
RUN puppet module install jfryman-nginx
RUN puppet apply /etc/puppet/manifests/nginx.pp
RUN puppet apply /etc/puppet/manifests/nginx_proxy.pp
CMD nginx -g 'daemon off;'
