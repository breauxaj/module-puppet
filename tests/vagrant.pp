node default {
  include ::puppet

  case $::operatingsystem {
    'Amazon': {
        Package { allow_virtual => false }
    }
    default: {}
  }

  puppet::standalone { 'default': }

}