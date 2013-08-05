# Class: ceph::params
#
# This class defines default parameters used by the main module class ceph
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to ceph class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class ceph::params {

  ### Application related parameters

  $use_cattlefish = true
  $dependency_class = 'ceph::dependency'

  $package = $::operatingsystem ? {
    default                   => 'ceph',
  }

  $service = $::operatingsystem ? {
    default                   => 'ceph',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'ceph',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'ceph',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/ceph',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/ceph/ceph.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/ceph.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/ceph',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/ceph',
  }

  $log_file = $::operatingsystem ? {
    default => [ '/var/log/ceph/ceph.log' ],
  }

  $port = '5000'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}
