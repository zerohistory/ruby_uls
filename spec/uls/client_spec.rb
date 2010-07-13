require File.dirname(__FILE__) + '/../spec_helper'

describe ULS::Client do
  it "takes credentials" do
    client = new_client
    client.consumer_key.should == "abcdefg1"
    client.consumer_secret.should == "abcdefg2"
    client.application_token.should == "abcdefg3"
    client.application_token_secret.should == "abcdefg4"
  end

  describe "key" do
    it "returns escaped secret keys, joined by &" do
      client = new_client
      key = URI.escape(client.consumer_secret) + '&' + URI.escape(client.application_token_secret)
      client.key.should == key
    end
  end

  describe "params" do
    it "includes proper names for default params" do
      client = new_client
      params = client.params
      params['oauth_token'].should == client.application_token
      params['oauth_consumer_key'].should == client.consumer_key
      params['oauth_signature_method'].should == 'HMAC-SHA1'
    end
  end
end
