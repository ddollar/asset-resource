require "asset_resource"
require "asset_resource/middleware"
require "active_support"
require 'asset_resource/framework/rails_view_helpers'

# example usage: put this in your application.rb
  # config.middleware.use AssetResource::Middleware,
    # :base_path => Rails.root.join("public"),
    # :handlers  => { :javascripts => "text/javascript",
                    # :stylesheets => "text/css" }
# end


ActiveSupport.on_load(:action_view) do
  include AssetResource::Helpers
end
