require "spec_helper"
require "asset_resource/middleware"

describe AssetResource::Middleware do

  let(:app) { lambda { |env| [ 200, {}, ['bar'] ]} }
  let(:middleware) { AssetResource::Middleware.new(app, :base_path => asset_fixture("normal")) }

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
    data = RestClient.get("http://localhost/assets/styles.css")
    data.should include "#1e5500"
    data.should include "#5a5500"
  end

  it "serves scripts with the proper mime type" do
    response = RestClient.get("http://localhost/assets/scripts.js")
    response.headers[:content_type].should == "text/javascript"
  end

  it "serves styles with the proper mime type" do
    response = RestClient.get("http://localhost/assets/styles.css")
    response.headers[:content_type].should == "text/css"
  end

  it "should not serve a file that begins with an underscore" do
    data = RestClient.get("http://localhost/assets/styles.css")
    data.should_not include "#c55000"
  end

  describe "with a blank file extension" do
    let(:middleware) { AssetResource::Middleware.new(app, :base_path => asset_fixture("blank_extension")) }

    it "should not try to render files with no extension" do
      data = RestClient.get("http://localhost/assets/styles.css")
      data.should include "#c55000"
    end
  end

  describe "with images" do
    let(:middleware) { AssetResource::Middleware.new(app, :base_path => asset_fixture("with_images")) }

    it "should not render unknown file types" do
      data = RestClient.get("http://localhost/assets/styles.css")
      data.should == "test\n"
    end
  end

  describe "with subdirs" do
    let(:middleware) { AssetResource::Middleware.new(app, :base_path => asset_fixture("with_subdir")) }

    it "should render files in subdirs" do
      data = RestClient.get("http://localhost/assets/styles.css")
      data.should == "test\n"
    end
  end

end
