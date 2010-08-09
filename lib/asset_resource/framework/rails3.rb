require "asset_resource"
require "asset_resource/middleware"
require "active_support"

ActiveSupport.on_load(:before_configuration) do
  Rails.application.config.middleware.use AssetResource::Middleware,
    :base_path => Rails.root.join("public"),
    :handlers  => { :javascripts => "text/javascript",
                    :stylesheets => "text/css" }
end

module AssetResource::Helpers
  def asset_resource_stylesheets
    '<link rel="stylesheet" href="/assets/stylesheets.css" />'.html_safe
  end

  def asset_resource_javascripts
    '<script type="text/javascript" src="/assets/javascripts.js"></script>'.html_safe
  end
end

ActiveSupport.on_load(:action_view) do
  include AssetResource::Helpers
end
