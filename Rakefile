require "rake"
require "rspec"
require "rspec/core/rake_task"

$:.unshift File.expand_path("../lib", __FILE__)
require "asset_resource"

task :default => :spec

desc "Run all specs"
Rspec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

desc "Generate RCov code coverage report"
task :rcov => "rcov:build" do
  %x{ open coverage/index.html }
end

Rspec::Core::RakeTask.new("rcov:build") do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rcov = true
  t.rcov_opts = [ "--exclude", Gem.default_dir , "--exclude", "spec" ]
end

######################################################

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name    = "asset-resource"
    s.version = AssetResource::VERSION

    s.summary     = "Manage CSS/JS assets as dynamic resources rather than static files"
    s.description = s.summary
    s.author      = "David Dollar"
    s.email       = "ddollar@gmail.com"
    s.homepage    = "http://github.com/ddollar/asset-resource"

    s.platform = Gem::Platform::RUBY
    s.has_rdoc = false

    s.files = %w(Rakefile README.md) + Dir["{bin,lib}/**/*"]
    s.require_path = "lib"

    s.add_development_dependency 'artifice',    '~> 0.5'
    s.add_development_dependency 'fakefs',      '~> 0.2.1'
    s.add_development_dependency 'haml',        '~> 3.0.9'
    s.add_development_dependency 'less',        '~> 1.2.21'
    s.add_development_dependency 'rake',        '~> 0.8.7'
    s.add_development_dependency 'rest-client', '~> 1.5.1'    
    s.add_development_dependency 'rcov',        '~> 0.9.8'
    s.add_development_dependency 'rspec',       '~> 2.0.0'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
