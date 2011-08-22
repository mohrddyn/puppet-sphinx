# Class: sphinx
#
# This module manages sphinx
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class sphinx {
  require sphinx::params
  
  include sphinx::install, sphinx::config, sphinx::service
}
