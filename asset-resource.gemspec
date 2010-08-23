require "rubygems"
require "parka/specification"

Parka::Specification.new do |gem|
  gem.name     = "asset-resource"
  gem.version  = AssetResource::VERSION
  gem.summary  = "Manage CSS/JS assets as dynamic resources rather than static files"
  gem.homepage = "http://github.com/ddollar/asset-resource"
end
