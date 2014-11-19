# = Class: voltdb
#
# This is the main voltdb class
#
#
# == Parameters
#

class voltdb (
  $version                 = params_lookup( 'version' ),
  $memory                  = params_lookup( 'memory' ),
  $data_dir                = params_lookup( 'data_dir' ),
  $license                 = params_lookup( 'license' ),
  $cluster_hostcount       = params_lookup( 'cluster_hostcount' ),
  $cluster_sitesperhost    = params_lookup( 'cluster_sitesperhost' ),
  $cluster_kfactor         = params_lookup( 'cluster_kfactor' ),
  $commandlog_enabled      = params_lookup( 'commandlog_enabled' ),
  $commandlog_synchronous  = params_lookup( 'commandlog_synchronous' ),
  $frequency_time          = params_lookup( 'frequency_time' ),
  $frequency_transactions  = params_lookup( 'frequency_transactions' ),
  $snapshot_enabled        = params_lookup( 'snapshot_enabled' ),
  $snapshot_frequency      = params_lookup( 'snapshot_frequency' ),
  $snapshot_prefix         = params_lookup( 'snapshot_prefix' ),
  $snapshot_retain         = params_lookup( 'snapshot_retain' ),
  $security_enabled        = params_lookup( 'security_enabled' ),
  $voltdb_path             = params_lookup( 'voltdb_path' ),
  $snapshots_path          = params_lookup( 'snapshots_path' ),
  $users                   = params_lookup( 'users' ),
  $httpd_port              = params_lookup( 'httpd_port' ),
  $jsonapi_enabled         = params_lookup( 'jsonapi_enabled' ),
) inherits voltdb::params {

    define url-package (
        $url,
        $provider,
        $package = undef,
    ) {

        if $package {
            $package_real = $package
        } else {
            $package_real = $title
        }

        $package_path = "/tmp/${package_real}"

        exec {'download':
            command => "/usr/bin/wget -O ${package_path} ${url}"
        }

        package {'install':
            ensure   => installed,
            name     => "${package}",
            provider => 'dpkg',
            source   => "${package_path}",
        }

        file {'cleanup':
            ensure => absent,
            path   => "${package_path}",
        }

        Exec['download'] -> Package['install'] -> File['cleanup']
    }

    ensure_packages(['openjdk-7-jdk', 'wget'])

    url-package {'VoltDB':
        url      => "http://voltdb.com/downloads/technologies/server/voltdb-ent_${version}-1_amd64.deb",
        provider => 'dpkg',
        require  => Package['openjdk-7-jdk', 'wget'],
    }

    # http://docs.voltdb.com/AdminGuide/adminmemmgt.php
    $max_map_count = $memory * 16384
    sysctl::value { 'vm.swappiness':   value => '0'}
    sysctl::value { 'vm.overcommit_memory':   value => '1'}
    sysctl::value { 'vm.max_map_count':   value => "${max_map_count}"}

    file { '/etc/voltdb':
        ensure => 'directory',
    }

    if $license {
        file { '/etc/voltdb/license.xml':
            content => $license,
        }
    }

    file { $data_dir:
        ensure => 'directory',
    }

    file { "${data_dir}/voltdb":
        ensure  => 'directory',
        require => File[$data_dir],
    }

    file { "${data_dir}/snapshots":
        ensure  => 'directory',
        require => File[$data_dir],
    }

    # Deployment configuration file
    file { '/etc/voltdb/deployment.xml':
        require => File['/etc/voltdb'],
        content => template('voltdb/deployment.xml.erb'),
    }
}
