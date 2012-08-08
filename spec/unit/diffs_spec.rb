require 'spec_helper'

describe Factual::API do
  include TestHelpers

  DIFF_TABLE = "2EH4Pz"

  it "should be able to get correct diffs url" do
    token = get_token
    api = get_api(token)

    start_date = Time.utc(2012, 1, 1)
    end_date = Time.utc(2012, 2, 1)
    diffs = api.diffs(DIFF_TABLE, :start => start_date, :end => end_date)

    token.last_url.should == "http://api.v3.factual.com/t/2EH4Pz/diffs?start=1325376000000&end=1328054400000"
  end
end
