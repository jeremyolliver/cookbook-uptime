#
# Cookbook Name:: application
# Recipe:: default
#
# Copyright (C) 2014 Jeremy Olliver
#
# All rights reserved - Do Not Redistribute
#

# Install MongoDB and create a db user
include_recipe 'uptime::database'
# Create 'uptime' user and install the app from source
include_recipe 'uptime::install'

###################
## Service script #
###################

# Only supports Upstart (ubuntu) right now

template '/etc/init/uptime.conf' do
  source 'uptime.conf'
  owner 'root'
  group 'root'
end

service 'uptime' do
  provider Chef::Provider::Service::Upstart
  action [:start, :enable]
end
