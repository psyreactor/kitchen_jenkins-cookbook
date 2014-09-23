case node[:platform_family]
when 'debian'
  default[:kitchen_jenkins][:packeges] = %w(libxml2-dev libxslt1-dev)
when 'rhel', 'fedora'
  default[:kitchen_jenkins][:packeges] = %w(libxml2-devel libxslt-devel)
end

default[:kitchen_jenkins][:theme][:css] = 'http://develop.source.test.do/dist/theme.css'
default[:kitchen_jenkins][:theme][:js] =  'http://develop.source.test.do/dist/theme.js'
default[:kitchen_jenkins][:kitchen][:driver] = 'vagrant'
default[:kitchen_jenkins][:plugins] = %w(git jquery simple-theme-plugin gravatar greenballs envinject config-file-provider ansicolor)
default[:kitchen_jenkins][:gems] = %W(foodcritic berkshelf chefspec test-kitchen kitchen-#{node[:kitchen_jenkins][:kitchen][:driver]} rubocop chef chef-zero)
default[:kitchen_jenkins][:proxy][:host] = nil
default[:kitchen_jenkins][:proxy][:port] = nil
