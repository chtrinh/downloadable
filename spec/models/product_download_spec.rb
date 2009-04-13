require File.dirname(__FILE__) + '/../spec_helper'

describe ProductDownload do
  before(:each) do
    @product_download = ProductDownload.new
  end

  it "should be valid" do
    @product_download.should be_valid
  end
end
