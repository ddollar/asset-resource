require "rubygems"

$:.unshift File.expand_path("../lib", __FILE__)
require "asset_resource/version"

Gem::Specification.new do |gem|
  gem.name     = "asset-resource"
  gem.version  = AssetResource::VERSION
  gem.homepage = "http://github.com/ddollar/asset-resource"

  gem.author   = "David Dollar"
  gem.email    = "ddollar@gmail.com"
  gem.summary  = "Manage CSS/JS assets as dynamic resources rather than static files"

  gem.files = Dir["**/*"].select { |d| d =~ %r{^(README|bin/|data/|ext/|lib/|spec/|test/)} }

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'artifice',    '~> 0.6'
  gem.add_development_dependency 'fakefs',      '~> 0.2.1'
  gem.add_development_dependency 'haml',        '~> 3.0.23'
  gem.add_development_dependency 'less',        '~> 1.2.21'
  gem.add_development_dependency 'rest-client', '~> 1.6.1'
  gem.add_development_dependency 'rcov',        '~> 0.9.8'
  gem.add_development_dependency 'rspec',       '~> 2.0.0'
end
