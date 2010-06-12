require "spec_helper"
require "asset_resource"

describe AssetResource do
  it "has a version" do
    AssetResource::VERSION.should be_a String
  end
end
