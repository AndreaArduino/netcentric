class{'nginx':
  log_format => {
    custom  => '$remote_addr "$http_x_forwarded_for" $scheme "$request_time" - [$time_local] "$request" $status "$http_user_agent"',
  },
}

nginx::resource::vhost { 'domain.com':
  ensure => 'present',
  server_name => ['domain.com'],
  ssl => true,
  ssl_port => '443',
  ssl_listen_option => true,
  ssl_cert => '/etc/pki/tls/certs/domain_com.crt',
  ssl_key => '/etc/pki/tls/private/domain_com.key',
  index_files => [],
  location_custom_cfg => {},
  rewrite_rules => ['^/$ $scheme://10.10.10.10 permanent'],
  vhost_cfg_append => {
      rewrite => '^(/resoure2|/resoure2/)$ $scheme://20.20.20.20 permanent',
  }
}
