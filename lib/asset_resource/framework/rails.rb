require "asset_resource/middleware"
require "active_support"

ActiveSupport.on_load(:before_configuration) do
  Rails.application.config.middleware.use AssetResource::Middleware,
    :base_path => Rails.root.join("public")
end
