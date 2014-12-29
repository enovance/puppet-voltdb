puppet-voltdb
=============

####Table of Contents

1. [Overview - What is the VoltDB module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [TODO](#todo)



##Overview

Simple module that can VoltDB database software

##Module Description

This module install VoltDB, configure the deployment file by puppet and add the license file.

##Setup

You can use it directly calling the module :

```puppet
class { 'voltdb': }
```

You can also configure it using Hiera :

```yaml
voltdb::data_dir:                     /var/lib/voltdb
voltdb::version:                      4.8 # actually last stable
voltdb::memory:                       64 # in giga
voltdb::cluster_hostcount:            3
voltdb::cluster_sitesperhost:         2
voltdb::cluster_kfactor:              1
voltdb::commandlog_enabled:           true
voltdb::commandlog_synchronous:       false
voltdb::frequency_time:               300
voltdb::frequency_transactions:       1000
voltdb::snapshot_enabled:             true
voltdb::snapshot_frequency:           1h
voltdb::snapshot_prefix:              voltdb
voltdb::snapshot_retain:              3
voltdb::security_enabled:             true
voltdb::voltdb_path:                  /var/lib/voltdb/voltdb/
voltdb::snapshots_path:               /var/lib/voltdb/snapshots/
voltdb::httpd_port:                   8080
voltdb::jsonapi_enabled:              true
voltdb::users:
    admin:
        name: admin
        password: adminpassword
        roles: 'dev,ops'
    user:
        name: user
        password: userpassword
        roles: user

voltdb::license:  |
    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <license>
        <permit version="1">
            <issuer>
                <company>VoltDB</company>
                <email>support@voltdb.com</email>
                <url>http://voltdb.com/</url>
            </issuer>
            <expiration>YYYY-MM-DD</expiration>
            <hostcount max="X"/>
            <features trial="false">
                <commandlogging>true</commandlogging>
            </features>
        </permit>
        <signature>
            XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        </signature>
    </license>
```

##Limitations

This module is known to work with the following operating system families:

 - Debian 7 or newer
 - Ubuntu 14.04 or newer

##TODO
 - Add tests
 - Add multiple operating system support
 - Add more configuration options to the deployment.xml file
