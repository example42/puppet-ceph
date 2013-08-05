# Class: ceph::dependency
#
# This class installs ceph dependency
#
# == Variables
#
# Refer to ceph class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# Note: This class may contain resources available on the
# Example42 modules set
#
class ceph::dependency {

  case $::operatingsystem {
    redhat,centos,scientific,oraclelinux : {
      if $ceph::bool_use_cuttlefish == true {
        require yum::repo::cuttlefish
      } else {
        # require yum::repo::epel
      }
    }
    ubuntu,debian : {
      if $ceph::bool_use_cuttlefish == true {
        require apt::repo::cuttlefish
      }
    }
    default: { }
  }
}
