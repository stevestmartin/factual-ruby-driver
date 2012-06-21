require 'spec_helper'

describe Factual::Query::Monetize do
  include TestHelpers

  before(:each) do
    @token = get_token
    @api = get_api(@token)
    @monetize = Factual::Query::Monetize.new(@api)
    @base = "http://api.v3.factual.com/places/monetize?"
  end

  it "should be able to use filters" do
    @monetize.filters("place_country" => "US").rows
    expected_url = @base + "filters={\"place_country\":\"US\"}"
    CGI::unescape(@token.last_url).should == expected_url
  end

  it "should be able to search" do
    @monetize.search("suchi", "sashimi").rows
    expected_url = @base + "q=suchi,sashimi"
    CGI::unescape(@token.last_url).should == expected_url
  end
end
