require 'spec_helper'
require 'asset_resource/framework/rails_view_helpers'


describe AssetResource::Helpers do
  class TestDummy
    include AssetResource::Helpers
  end

  class String
    def html_safe
      self
    end
  end

  describe "#asset_resource_stylesheets" do
    let(:helper) { TestDummy.new }
    context "when you don't pass in a resource name" do
      it "points to stylesheets.css" do
        helper.asset_resource_stylesheets.should include("stylesheets.css")
      end
    end

    context "when you pass in a resource name" do
      it "points to the desired resource" do
        helper.asset_resource_stylesheets("another_stylesheet").should include("another_stylesheet.css")
      end
    end
  end
  describe "#asset_resource_javascripts" do
    let(:helper) { TestDummy.new }
    context "when you don't pass in a resource name" do
      it "points to javascripts.js" do
        helper.asset_resource_javascripts.should include("javascripts.js")
      end
    end

    context "when you pass in a resource name" do
      it "points to the desired resource" do
        helper.asset_resource_javascripts("another_resource").should include("another_resource.js")
      end
    end
  end
end
