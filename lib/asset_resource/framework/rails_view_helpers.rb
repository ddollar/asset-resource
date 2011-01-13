module AssetResource
  module Helpers
    def asset_resource_stylesheets(resource_name = "stylesheets")
      "<link rel='stylesheet' href='/assets/#{resource_name}.css?#{Time.now.to_i}' />".html_safe
    end

    def asset_resource_javascripts(resource_name = "javascripts")
      "<script type='text/javascript' src='/assets/#{resource_name}.js?#{Time.now.to_i}'></script>".html_safe
    end
  end
end
