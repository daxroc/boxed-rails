#
# Cookbook Name:: boxed-rails
# Recipe:: default
#
# Copyright (c) 2015 Damien Roche, All Rights Reserved.

deploy = '/srv/boxed-app'
app_repo = 'https://github.com/daxroc/boxed-app.git'
#owner = 'webapps'
#group = 'webapps'

include_recipe 'yum-epel'
include_recipe 'boxed-rails::users'
include_recipe 'boxed-rails::build_essential'

# Create directories
directory deploy do
#  owner owner
#  group group
#  mode 0754
  action :create
  recursive true
end

package %w{nodejs git sqlite-devel}

poise_service_user 'webapps'

application deploy do
  
#  owner 'webapps'
#  group 'webapps'

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

