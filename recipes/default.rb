#
# Cookbook Name:: boxed-rails
# Recipe:: default
#
# Copyright (c) 2015 Damien Roche, All Rights Reserved.

deploy = '/srv/boxed-app'
app_repo = 'https://github.com/daxroc/boxed-app.git'
owner = 'webapps'
group = 'webapps'

include_recipe 'yum-epel'
include_recipe 'boxed-rails::users'
include_recipe 'boxed-rails::build_essential'

# Create directories
directory deploy do
  owner owner
  group group
  action :create
  recursive true
end

package %w{nodejs git sqlite-devel}


#poise_service_user 'webapps'

application deploy do
  
  owner 'webapps'
  group 'webapps'

  git app_repo do
    revision 'deploy'
  end

  ruby do
    version '2.2'
  end

  bundle_install do
    without %w{development test}
    deployment true
  end

  rails do 
    secret_token 'abc123'
  end

  unicorn do
    port 8000
  end

end


# 
return 

# Create directories
directory deploy do
  owner owner
  group group
  action :create
  recursive true
end


# Enable EPEL 
include_recipe 'yum-epel'


# Install required packages
package 'nodejs'
package 'git'


# Support for Database
package 'sqlite-devel'


git deploy do
  repository app_repo
  revision 'deploy'
  action :sync
  user owner
  group group
end

#node.default['poise-ruby']['install_chef_ruby'] = false

#ruby_runtime '2.2'
#ruby_gem 'rake'
#ruby_gem 'bundler'

bundle_install deploy do
  without %w{development test}
  deployment true
end

application deploy do
  rails do
    secret_token 'abc123'
  end
  unicorn do
    port 8000
  end
end






return

application '/boxed' do
  ruby '2.2'
  ruby_gem 'bundler'
  owner owner
  group group
end

application '/boxed' do
  owner owner
  group group
#  ruby '2.2'
#  ruby_gem 'bundler'
  git do
    repository app_repo
    checkout_branch 'deploy'
  end
  rails do
#    database 'sqlite3:///db.sqlite3'
    secret_token 'dbajaosjasof30'
#    migrate true
  end
  bundle_install do
    deployment true
    without %w{development test}
  end
  unicorn do
    port 8000
  end
end 

