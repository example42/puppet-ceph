#
# = Class: ceph
#
# This class installs and manages ceph
#
#
# == Parameters
#
# Refer to https://github.com/stdmod for official documentation
# on the stdmod parameters used
#
class ceph (

  $package_name              = $ceph::params::package_name,
  $package_ensure            = 'present',

  $service_name              = $ceph::params::service_name,
  $service_ensure            = 'running',
  $service_enable            = true,

  $config_file_path          = $ceph::params::config_file_path,
  $config_file_require       = 'Package[ceph]',
  $config_file_notify        = 'Service[ceph]',
  $config_file_source        = undef,
  $config_file_template      = undef,
  $config_file_content       = undef,
  $config_file_options_hash  = { } ,

  $config_dir_path           = $ceph::params::config_dir_path,
  $config_dir_source         = undef,
  $config_dir_purge          = false,
  $config_dir_recurse        = true,

  $conf_hash                 = undef,

  $dependency_class          = 'ceph::dependency',
  $my_class                  = undef,

  $monitor_class             = undef,
  $monitor_options_hash      = { } ,

  $firewall_class            = undef,
  $firewall_options_hash     = { } ,

  $scope_hash_filter         = '(uptime.*|timestamp)',

  $tcp_port                  = undef,
  $udp_port                  = undef,

  ) inherits ceph::params {


  # Class variables validation and management

  validate_bool($service_enable)
  validate_bool($config_dir_recurse)
  validate_bool($config_dir_purge)
  if $config_file_options_hash { validate_hash($config_file_options_hash) }
  if $monitor_options_hash { validate_hash($monitor_options_hash) }
  if $firewall_options_hash { validate_hash($firewall_options_hash) }

  $config_file_owner          = $ceph::params::config_file_owner
  $config_file_group          = $ceph::params::config_file_group
  $config_file_mode           = $ceph::params::config_file_mode

  $manage_config_file_content = default_content($config_file_content, $config_file_template)

  $manage_config_file_notify  = $config_file_notify ? {
    'class_default' => 'Service[ceph]',
    ''              => undef,
    default         => $config_file_notify,
  }

  if $package_ensure == 'absent' {
    $manage_service_enable = undef
    $manage_service_ensure = stopped
    $config_dir_ensure = absent
    $config_file_ensure = absent
  } else {
    $manage_service_enable = $service_enable
    $manage_service_ensure = $service_ensure
    $config_dir_ensure = directory
    $config_file_ensure = present
  }


  # Dependency class

  if $ceph::dependency_class {
    include $ceph::dependency_class
  }


  # Resources managed

  if $ceph::package_name {
    package { 'ceph':
      ensure   => $ceph::package_ensure,
      name     => $ceph::package_name,
    }
  }

  if $ceph::config_file_path {
    file { 'ceph.conf':
      ensure  => $ceph::config_file_ensure,
      path    => $ceph::config_file_path,
      mode    => $ceph::config_file_mode,
      owner   => $ceph::config_file_owner,
      group   => $ceph::config_file_group,
      source  => $ceph::config_file_source,
      content => $ceph::manage_config_file_content,
      notify  => $ceph::manage_config_file_notify,
      require => $ceph::config_file_require,
    }
  }

  if $ceph::config_dir_source {
    file { 'ceph.dir':
      ensure  => $ceph::config_dir_ensure,
      path    => $ceph::config_dir_path,
      source  => $ceph::config_dir_source,
      recurse => $ceph::config_dir_recurse,
      purge   => $ceph::config_dir_purge,
      force   => $ceph::config_dir_purge,
      notify  => $ceph::manage_config_file_notify,
      require => $ceph::config_file_require,
    }
  }

  if $ceph::service_name {
    service { 'ceph':
      ensure     => $ceph::manage_service_ensure,
      name       => $ceph::service_name,
      enable     => $ceph::manage_service_enable,
    }
  }


  # Extra classes

  if $conf_hash {
    create_resources('ceph::conf', $conf_hash)
  }

  if $ceph::my_class {
    include $ceph::my_class
  }

  if $ceph::monitor_class {
    class { $ceph::monitor_class:
      options_hash => $ceph::monitor_options_hash,
      scope_hash   => {}, # TODO: Find a good way to inject class' scope
    }
  }

  if $ceph::firewall_class {
    class { $ceph::firewall_class:
      options_hash => $ceph::firewall_options_hash,
      scope_hash   => {},
    }
  }

}

