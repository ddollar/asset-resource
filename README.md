# AssetResource

Serve up your CSS and Javascript as first-class resources.

Supports in-line rendering of engines such as Sass and Less. These files will
be served with 24-hour HTTP cache expiry.

Built-in configuration and helpers for Rails 2.x, Rails 3.x and Sinatra.

## Usage

### Rails 2.x

    # public/stylesheets/*.{css|less|sass}
    # public/javascripts/*.js

    # config/environment.rb
    config.gem "asset-resource"

    # app/views/layouts/application.html.erb
    <html>
      <head>
        <%= asset_resource_stylesheets %>
        <%= asset_resource_scripts %>
      </head>
    </html>

### Rails 3.x

    # public/stylesheets/*.{css|less|sass}
    # public/javascripts/*.js

    # Gemfile
    gem "asset_resource"

    # app/views/layouts/application.html.erb
    <html>
      <head>
        <%= asset_resource_stylesheets %>
        <%= asset_resource_scripts %>
      </head>
    </html>

### Sinatra

    # assets/styles/*.{css|less|sass}
    # assets/scripts/*.js

    # app.rb
    require "asset_resource"

    class App < Sinatra::Base
      register Sinatra::AssetResource
    end

    __END__

    @@ layout
    %html
      %head
        = asset_resource_scripts
        = asset_resource_styles

## Technical Details

  `AssetResource::Middleware` serves requests at `/assets/stylesheets.css` and
`/assets/javascripts.js`.

The gem will add appropriate view helpers to your framework of choice.

You can use the middleware yourself like this:

    use AssetResource::Middleware,
      :base_path => "public",
      :handlers  => { :javascripts => "text/javascript",
                      :stylesheets => "text/css" }

## Copyright

MIT License

## Author

David Dollar

[http://daviddollar.org](http://daviddollar.org)
