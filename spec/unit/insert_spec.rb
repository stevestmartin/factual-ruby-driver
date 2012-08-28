require 'spec_helper'

describe Factual::Write::Insert do
  include TestHelpers

  before(:each) do
    @token = get_token
    @api = get_api(@token)
    @basic_params = {
      :table => "global",
      :user => "user123",
      :values => { :name => "McDonalds" } }
    @klass = Factual::Write::Insert
    @insert = @klass.new(@api, @basic_params)
  end

  it "should be able to write a basic insert input" do
    @insert.write
    @token.last_url.should == "http://api.v3.factual.com/t/global/insert"
    @token.last_body.should == "user=user123&values=%7B%22name%22%3A%22McDonalds%22%7D"
  end

  it "should be able to set a table" do
    @insert.table("places").write
    @token.last_url.should == "http://api.v3.factual.com/t/places/insert"
    @token.last_body.should == "user=user123&values=%7B%22name%22%3A%22McDonalds%22%7D"
  end

  it "should be able to set a user" do
    @insert.user("user456").write
    @token.last_url.should == "http://api.v3.factual.com/t/global/insert"
    @token.last_body.should == "user=user456&values=%7B%22name%22%3A%22McDonalds%22%7D"
  end

  it "should be able to set a factual_id" do
    @insert.factual_id("1234567890").write
    @token.last_url.should == "http://api.v3.factual.com/t/global/1234567890/insert"
    @token.last_body.should == "user=user123&values=%7B%22name%22%3A%22McDonalds%22%7D"
  end

  it "should be able to set values" do
    @insert.values({ :new_key => :new_value }).write
    @token.last_url.should == "http://api.v3.factual.com/t/global/insert"
    @token.last_body.should == "user=user123&values=%7B%22new_key%22%3A%22new_value%22%7D"
  end

  it "should be able to set comment and reference" do
    @insert.table("places").comment('foobar').reference('yahoo.com/d/').write
    @token.last_url.should == "http://api.v3.factual.com/t/places/insert"
    @token.last_body.should == "user=user123&values=%7B%22name%22%3A%22McDonalds%22%7D&comment=foobar&reference=yahoo.com%2Fd%2F"
  end

  it "should not allow an invalid param" do
    raised = false
    begin
      bad_insert = @klass.new(@api, :foo => "bar")
    rescue
      raised = true
    end
    raised.should == true
  end

  it "should be able to return a valid path if no factual_id is set" do
    @insert.path.should == "/t/global/insert"
  end

  it "should be able to return a valid path if a factual_id is set" do
    @insert.factual_id("foo").path.should == "/t/global/foo/insert"
  end

  it "should be able to return a body" do
    @insert.body.should == "user=user123&values=%7B%22name%22%3A%22McDonalds%22%7D"
  end
end
