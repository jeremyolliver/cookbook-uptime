#
# Cookbook Name:: application
# Recipe:: default
#
# Copyright (C) 2014 Jeremy Olliver
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'nodejs'
include_recipe 'mongodb'

group 'uptime'
user 'uptime'

directory '/opt/uptime' do
  recursive true
  owner 'uptime'
  group 'uptime'
  mode '0755'
end

git 'uptime' do
  path '/opt/uptime'
  repository node['uptime']['repo']['url']
  revision   node['uptime']['repo']['ref']
  action     :sync
  notifies   :run, "execute[uptime-install]"
end

execute 'uptime-install' do
  cwd '/opt/uptime'
  command 'npm install'
end

template '/opt/uptime/config/production.yml' do
  source 'config.yml.erb'
  cookbook 'uptime'
  owner 'uptime'
  group 'uptime'
  mode '0644'
  variables({
    url:              node['uptime']['url'],
    plugins:          node['uptime']['plugins'],
    external_plugins: node['uptime']['external_plugins'],
    monitor_config:   node['uptime']['monitor'],
    analyzer_config:  node['uptime']['analyzer']
  })
end
