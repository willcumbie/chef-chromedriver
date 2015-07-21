# encoding: UTF-8

package 'unzip'

execute 'unzip_chromedriver' do
  command "unzip -j -o #{node['chromedriver']['download_path']} chromedriver -d #{node['chromedriver']['install_path']}"
  action :nothing
  notifies :touch, "file[#{node['chromedriver']['install_path']}/chromedriver]"
end

file "#{node['chromedriver']['install_path']}/chromedriver" do
  owner 'root'
  group 'root'
  mode '755'
  action :nothing
end

remote_file node['chromedriver']['download_path'] do
  source node['chromedriver']['source_url']
  notifies :run, 'execute[unzip_chromedriver]', :immediately
end
