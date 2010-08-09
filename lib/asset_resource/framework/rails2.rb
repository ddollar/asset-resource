require "asset_resource"
require "asset_resource/middleware"

module AssetResource::Helpers
  def asset_resource_stylesheets
    '<link rel="stylesheet" href="/assets/stylesheets.css" />'.html_safe
  end

  def asset_resource_javascripts
    '<script type="text/javascript" src="/assets/javascripts.js"></script>'.html_safe
  end
end

Rails.configuration.middleware.use AssetResource::Middleware,
  :base_path => Rails.root.join("public"),
  :handlers  => { :javascripts => "text/javascript",
                  :stylesheets => "text/css" }

ActionView::Base.send :include, AssetResource::Helpers
