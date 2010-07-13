require File.dirname(__FILE__) + '/../spec_helper'

describe ULS::Client do
  it "takes credentials" do
    client = ULS::Client.new \
      :consumer_key => "abcdefg1",
      :consumer_secret => "abcdefg2",
      :application_token => "abcdefg3",
      :application_token_secret => "abcdefg4"

    client.consumer_key.should == "abcdefg1"
    client.consumer_secret.should == "abcdefg2"
    client.application_token.should == "abcdefg3"
    client.application_token_secret.should == "abcdefg4"
  end

  describe "nonce" do
    it "contains no non-word characters" do
      client = ULS::Client.new
      client.nonce.should_not =~ /\W/
    end
  end

  describe "timestamp" do
    it "returns string form of Time.now.to_i" do
      t = Time.now ; Time.stub!(:now).and_return(t)
      client = ULS::Client.new
      client.timestamp.should == t.to_i.to_s
    end
  end
end
