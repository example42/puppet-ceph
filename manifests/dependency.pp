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
      require yum::repo::cuttlefish
    }
    ubuntu,debian : {
      require apt::repo::cuttlefish
    }
    default: { }
  }
}
