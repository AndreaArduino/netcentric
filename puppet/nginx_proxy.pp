class{'nginx': }

nginx::resource::vhost{'forward_proxy':
  ensure   => 'present',
  listen_port  => '8080',
  #server_name => ,
  proxy_set_header => ['Host $http_host'],
  proxy => 'http://$http_host$uri$is_args$args',
  resolver => ['8.8.8.8'],
}

