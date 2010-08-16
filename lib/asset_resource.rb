module AssetResource
  VERSION = "0.2.1"
end

if defined?(Rails)
  require "asset_resource/framework/rails#{Rails::VERSION::MAJOR}"
end

if defined?(Sinatra)
  require "asset_resource/framework/sinatra"
end
