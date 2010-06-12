require "rubygems"
require "rspec"
require "artifice"
require "rest_client"

$:.unshift "lib"

def asset_fixture(name="")
  File.expand_path("../fixtures/#{name}", __FILE__)
end

Rspec.configure do |config|
  config.color_enabled = true
end
