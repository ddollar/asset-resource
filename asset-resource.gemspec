require "rubygems"

$:.unshift File.expand_path("../lib", __FILE__)
require "asset_resource"

Gem::Specification.new do |gem|
  gem.name     = "asset-resource"
  gem.version  = AssetResource::VERSION
  gem.summary  = "Manage CSS/JS assets as dynamic resources rather than static files"
  gem.homepage = "http://github.com/ddollar/asset-resource"
  gem.author   = "David Dollar"
  gem.email    = "ddollar@gmail.com"
end
