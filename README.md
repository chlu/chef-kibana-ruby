# <a name="title"></a> chef-kibana-ruby [![Build Status](https://secure.travis-ci.org/chlu/chef-kibana-ruby.png)](http://travis-ci.org/chlu/chef-kibana-ruby)

Description
===========

A simple cookbook that installs [Kibana](https://github.com/rashidkpc/Kibana) in the new Ruby version. Kibana is a web frontend for analysing Logstash messages in an Elasticsearch index. 

Requirements
============

Kibana requires a working installation of Elasticsearch and Logstash.

This cookbook depends on `rvm` for providing the Ruby installation. It has been tested on Ubuntu 10.04 so far.

Attributes
==========

* `node[:kibana][:version]` - The version of Kibana to download (corresponds to a tag on Github). Note: Only Ruby versions (starting with 0.2.0) are supported.
* `node[:kibana][:checksum]` - The MD5 checksum of the downloaded .tar.gz file.
* `node[:kibana][:home]` - The home directory for the Kibana system user, the current version will be linked as `current` inside this directory.
* `node[:kibana][:user]` - System user for Kibana, defaults to `kibana`.
* `node[:kibana][:group]` - System group for Kibana, defaults to `kibana`.
* `node[:kibana][:ruby_version]` - RVM Ruby version for Kibana, defaults to `ruby-1.9.3-p125`.
* `node[:kibana][:config]` - A hash of configuration options for Kibana. These match the options available in Kibana's `KibanaConfig.rb` file. See `attributes/default.rb` for more information.

Recipes
=======

* `default` - Downloads Kibana Ruby version from Github, creates a system user specifed by the `user` attribute and extracts it inside the home directory specified by the `home` attribute. It then writes the `KibanaConfig.rb` file based on values contained in the `node[:kibana][:config]` attribute namespace.

License and Author
==================

- Author::      Christopher Hlubek (<hlubek@networkteam.com>)

- Copyright::   2012, networkteam GmbH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
