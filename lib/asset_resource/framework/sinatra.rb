require "asset_resource/middleware"

module Sinatra
  module AssetResource
    def self.registered(app)
      app.use ::AssetResource::Middleware,
        :base_path => File.join(app.root, "assets"),
        :handlers  => { :scripts => "text/javascript",
                        :styles  => "text/css" }

      app.helpers Sinatra::AssetResource::Helpers
    end

    module Helpers
      def asset_resource_styles
        '<link rel="stylesheet" href="/assets/styles.css" />'
      end

      def asset_resource_scripts
        '<script type="text/javascript" src="/assets/scripts.js"></script>'
      end
    end
  end

  register AssetResource
end
