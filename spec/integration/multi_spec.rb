require 'spec_helper'
require 'yaml'

CREDENTIALS_FILE = File.expand_path('./key_secret.yaml', File.dirname(__FILE__))

describe "Multi API" do
  before(:all) do
    credentials = YAML.load(File.read(CREDENTIALS_FILE))
    key = credentials["key"]
    secret = credentials["secret"]
    @factual = Factual.new(key, secret)
  end

  it "should be able to do multi queries" do
    places_query = @factual.table("places").search('sushi').filters(:postcode => 90067)
    geocode_query = @factual.geocode(34.06021,-118.41828)

    multi = @factual.send_multi do |queries|
      queries[:nearby_sushi] = places_query
      queries[:factual_inc] = geocode_query
    end

    puts multi[:nearby_sushi].first.inspect
    puts multi[:factual_inc].first.inspect

    multi[:nearby_sushi].rows.length.should == 20
    multi[:nearby_sushi].rows.each do |row|
      row.class.should == Hash
      row.keys.should_not be_empty
    end

    multi[:factual_inc].first["postcode"].should == "90067"
  end
end
