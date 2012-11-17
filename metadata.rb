name             "kibana"
version          "0.1.0"
maintainer       "networkteam GmbH"
maintainer_email "hlubek@networkteam.com"
license          "Apache 2.0"
description      "Installs Kibana (new Ruby version) web frontend for Logstash"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

supports         "ubuntu"
supports         "debian"

supports         "redhat"
supports         "centos"
supports         "scientific"
supports         "amazon"
supports         "fedora"

depends "runit"
depends "apt"
depends "yum"
depends "rvm"
depends "logstash"
