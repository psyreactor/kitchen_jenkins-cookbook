# Encoding: utf-8
require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.tty = true
  config.log_level = :error
end

ChefSpec::Coverage.start!
