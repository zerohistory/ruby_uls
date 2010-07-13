require File.dirname(__FILE__) + '/../spec_helper'

describe ULS::Client do
  it "takes credentials" do
    client = ULS::Client.new \
      :consumer_key => "abcdefg",
      :consumer_secret => "abcdefg",
      :application_token => "abcdefg",
      :application_token_secret => "abcdefg"

    client.consumer_key.should == "abcdefg"
    client.consumer_secret.should == "abcdefg"
    client.application_token.should == "abcdefg"
    client.application_token_secret.should == "abcdefg"
  end
end
