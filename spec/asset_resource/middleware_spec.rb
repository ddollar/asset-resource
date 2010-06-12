require "spec_helper"
require "asset_resource/middleware"

describe AssetResource::Middleware do
  let(:app) { lambda { |env| [ 200, {}, ['bar'] ]} }
  let(:middleware) { AssetResource::Middleware.new(app, :base_path => asset_fixture) }

  before(:each) do
    Artifice.activate_with(middleware)
  end

  it "passes unhandled requests" do
    RestClient.get("http://localhost/foo").to_s.should == "bar"
  end

  it "serves with cache headers" do
    response = RestClient.get("http://localhost/assets/scripts.js")
    response.headers[:cache_control].should =~ /public/
  end

  it "can set custom asset headers" do
    middleware.options[:asset_headers] = { "X-Foo" => "Bar" }
    response = RestClient.get("http://localhost/assets/scripts.js")
    response.headers[:cache_control].should_not =~ /public/
    response.headers[:x_foo].should == "Bar"
  end

  it "serves scripts" do
    data = RestClient.get("http://localhost/assets/scripts.js")
    data.should include "console.log('hello!')"
  end

  it "serves styles" do
    data = RestClient.get("http://localhost/assets/stylesheets.css")
    data.should include "color: #1e5500"
    data.should include "color: #5a5500"
  end

end
