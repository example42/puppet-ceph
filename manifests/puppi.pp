class ceph::puppi {

  # For Puppi 2 (WIP)
  $classvars=get_class_args()
  puppi::ze { 'ceph':
    ensure    => $ceph::manage_file,
    variables => $classvars,
    helper    => $ceph::puppi_helper,
    noop      => $ceph::noops,
  }

  # For Puppi 1
  puppi::info::module { "ceph":
    packagename => "${ceph::package}",
    servicename => "${ceph::service}",
    processname => "${ceph::process}",
    configfile  => "${ceph::config_file}",
    configdir   => "${ceph::config_dir}",
    pidfile     => "${ceph::pid_file}",
    datadir     => "${ceph::data_dir}",
    logdir      => "${ceph::log_dir}",
    protocol    => "${ceph::protocol}",
    port        => "${ceph::port}",
    description => "What Puppet knows about ceph" ,
    # run         => "ceph -V###",
  }

  puppi::log { "ceph":
    description => "Logs of ceph" ,
    log      => "${ceph::log_file}",
  }

}
