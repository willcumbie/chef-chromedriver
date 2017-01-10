# encoding: UTF-8

default['chromedriver']['version'] = '2.27'
default['chromedriver']['platform'] = 'linux64'
default['chromedriver']['archive'] = "chromedriver_#{node['chromedriver']['platform']}.zip"
default['chromedriver']['source_url'] = "http://chromedriver.storage.googleapis.com/#{node['chromedriver']['version']}/#{node['chromedriver']['archive']}"
default['chromedriver']['download_path'] = "#{Chef::Config[:file_cache_path]}/#{node['chromedriver']['archive']}"
default['chromedriver']['install_path'] = '/usr/bin'
