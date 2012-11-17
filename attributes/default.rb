default['kibana']['home'] = "/home/kibana"
default['kibana']['user'] = "kibana"
default['kibana']['group'] = "kibana"

default['kibana']['pid_dir'] = "/var/run/kibana"
default['kibana']['log_dir'] = "/var/log/kibana"

default['kibana']['version'] = "0.2.0b2"
default['kibana']['file'] = "v#{node['kibana']['version']}.tar.gz"
default['kibana']['download_url'] = "https://github.com/rashidkpc/Kibana/archive/#{node['kibana']['file']}"
default['kibana']['checksum'] = "d3d07a78063f938ce0477e17d970706f"

default['kibana']['ruby_version'] = "ruby-1.9.3-p125"

# The elastic search server(s). This may be set as an array for round robin
# load balancing (e.g. ["elasticsearch1:9200", "elasticsearch2:9200"]).
default['kibana']['config']['elasticsearch'] = "localhost:9200"
default['kibana']['config']['port'] = 5601
# The listen address for Kibana, defaults to all interfaces.
default['kibana']['config']['host'] = "0.0.0.0"
default['kibana']['config']['type'] = ""
default['kibana']['config']['per_page'] = 50
default['kibana']['config']['timezone'] = "user"
default['kibana']['config']['time_format'] = "mm/dd HH:MM:ss"
default['kibana']['config']['default_fields'] = ["@message"]
default['kibana']['config']['default_operator'] = "OR"
default['kibana']['config']['analyze_limit'] = 2000
default['kibana']['config']['analyze_show'] = 25
default['kibana']['config']['rss_show'] = 20
default['kibana']['config']['export_show'] = 2000
default['kibana']['config']['export_delimiter'] = ","
default['kibana']['config']['filter'] = ""
default['kibana']['config']['smart_index'] = true
default['kibana']['config']['smart_index_pattern'] = 'logstash-%Y.%m.%d'
default['kibana']['config']['smart_index_limit'] = 60
