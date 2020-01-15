class{'nginx':
  log_format => {
    custom  => '$remote_addr "$http_x_forwarded_for" $scheme "$request_time" - [$time_local] "$request" $status "$http_user_agent"',
  },
}

nginx::resource::vhost{'forward_proxy':
  ensure => 'present',
  listen_port => '8080',
  index_files => [],
  proxy_set_header => ['Host $http_host'],
  proxy => '$scheme://$http_host$uri$is_args$args',
  resolver => ['8.8.8.8'],
  format_log => 'custom',
}
