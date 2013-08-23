exec { "apt-get update":
  command => "/usr/bin/apt-get update",
}

package { [ 'vim', 'build-essential','openssl','libcurl4-openssl-dev','libreadline6','libreadline6-dev','curl','git-core','zlib1g','zlib1g-dev','libssl-dev','libyaml-dev','libsqlite3-0','libsqlite3-dev','sqlite3','libxml2-dev','libxslt-dev','autoconf','libc6-dev','ncurses-dev','automake','libtool','bison','libbz2-dev','libmysqlclient-dev' ]:
  ensure => 'latest',
  require => Exec['apt-get update']
}

class { 'rbenv': require => Package['git-core'] }->rbenv::plugin { [ 'sstephenson/rbenv-vars', 'sstephenson/ruby-build' ]: }
rbenv::build { '2.0.0-p247': global => true } ->
rbenv::gem { 'bundler': ruby_version => '2.0.0-p247' } ->

class { 'mysql': require => Exec['apt-get update'] }->
class { 'mysql::ruby': }->
class { 'mysql::server':
  config_hash => { 'root_password' => 'q1w2e3r4' },
  require => Exec['apt-get update'],
} ->
mysql::db { 'saap_dev':
  user     => 'saap_dev',
  password => 'q1w2e3r4',
  host     => '127.0.0.1',
  grant    => ['all'],
}
