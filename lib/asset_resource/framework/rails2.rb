require "asset_resource"
require "asset_resource/middleware"
require 'asset_resource/framework/rails_view_helpers'

Rails.configuration.middleware.use AssetResource::Middleware,
  :base_path => Rails.root.join("public"),
  :handlers  => { :javascripts => "text/javascript",
                  :stylesheets => "text/css" }

ActionView::Base.send :include, AssetResource::Helpers
