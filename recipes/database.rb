#
# Cookbook Name:: application
# Recipe:: database
#
# Copyright (C) 2014 Jeremy Olliver
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mongodb::mongodb_org_repo' # to ensure we get a recent enough version
include_recipe 'mongodb::default'
