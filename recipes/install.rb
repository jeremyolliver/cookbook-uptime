include_recipe 'build-essential' # Needed for some npm package dependencies (g++)
include_recipe 'git'
include_recipe 'nodejs'
include_recipe 'nodejs::npm'

group 'uptime'

user 'uptime' do
  gid 'uptime'
  shell '/bin/bash'
  supports manage_home: true
  home '/opt/uptime'
end

app_root = '/opt/uptime/src'

git app_root do
  repository node['app_uptime']['repo']['url']
  revision   node['app_uptime']['repo']['ref']
  action     :sync
  user       'uptime'
  group      'uptime'
  notifies   :run, 'bash[uptime-npm-install]'
  notifies   :restart, 'service[uptime]'
end

template "#{app_root}/config/production.yml" do
  source   'config.yml.erb'
  cookbook 'uptime'
  owner    'uptime'
  group    'uptime'
  mode     '0644'
  variables({
    url:              node['app_uptime']['url'],
    plugins:          node['app_uptime']['plugins'],
    external_plugins: node['app_uptime']['external_plugins'],
    monitor_config:   node['app_uptime']['monitor'],
    analyzer_config:  node['app_uptime']['analyzer'],
    mongo_user:       node['app_uptime']['mongo']['user'],
    mongo_password:   node['app_uptime']['mongo']['password'],
    config:           node['app_uptime']['config']
  })
  notifies :restart, 'service[uptime]'
end

bash "uptime-npm-install" do
  user 'uptime'
  group 'uptime'
  environment({
    'HOME'     => '/opt/uptime',
    'NODE_ENV' => 'production'
  })
  cwd app_root
  code "/usr/bin/npm install"
  action :nothing # only run when git source changes
end
