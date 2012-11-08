require 'spec_helper'

describe Factual::Write::Clear do
  include TestHelpers

  before(:each) do
    @token = get_token
    @api = get_api(@token)
    @basic_params = {
      :table => "global",
      :factual_id => "id123",
      :user => "user123" }
    @klass = Factual::Write::Clear
    @clear = @klass.new(@api, @basic_params).fields(:lat, :lng)
  end

  it "should be able to write a basic clear" do
    @clear.write
    @token.last_url.should == "http://api.v3.factual.com/t/global/id123/clear"
    @token.last_body.should == "user=user123&fields=lat%2Clng"
  end

  it "should not allow an invalid param" do
    bad_params = @basic_params.merge!(:foo => :bar)
    raised = false
    begin
      bad_clear = @klass.new(@api, bad_params)
    rescue
      raised = true
    end
    raised.should == true
  end

  it "should be able to set a comment" do
    @clear.comment("This is my comment").write
    @token.last_url.should == "http://api.v3.factual.com/t/global/id123/clear"
    @token.last_body.should == "user=user123&fields=lat%2Clng&comment=This+is+my+comment"
  end

  it "should be able to set a reference" do
    @clear.reference("http://www.google.com").write
    @token.last_url.should == "http://api.v3.factual.com/t/global/id123/clear"
    @token.last_body.should == "user=user123&fields=lat%2Clng&reference=http%3A%2F%2Fwww.google.com"
  end

  it "should be able to return a path" do
    @clear.path.should == "/t/global/id123/clear"
  end

  it "should be able to return a body" do
    @clear.body.should == "user=user123&fields=lat%2Clng"
  end
end
