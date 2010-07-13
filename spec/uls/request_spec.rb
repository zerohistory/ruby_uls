require File.dirname(__FILE__) + '/../spec_helper'

describe ULS::Request do
  it "parses its uri" do
    request = new_request
    request.uri.should == URI.parse('http://example.com')
  end

  describe "nonce" do
    it "contains no non-word characters" do
      request = new_request
      request.nonce.should_not =~ /\W/
    end
  end

  describe "params" do
    it "includes request params" do
      request = new_request(new_client, 'GET', 'http://example.com/?foo=bar')
      request.params['foo'].should == 'bar'
    end

    it "merges client params" do
      client = new_client
      request = new_request(client)
      request.params.keys.should include(*client.params.keys)
    end

    it "includes nonce" do
      request = new_request
      request.params['oauth_nonce'].should == request.nonce
    end

    it "includes timestamp" do
      request = new_request
      request.params['oauth_timestamp'].should == request.timestamp
    end
  end

  describe "timestamp" do
    it "returns string form of Time.now.to_i" do
      t = Time.now ; Time.stub!(:now).and_return(t)
      request = new_request
      request.timestamp.should == t.to_i.to_s
    end
  end

  describe "signature_base" do
    it "includes the HTTP method" do
      request = new_request(new_client, 'GET', 'http://example.com')
      base = request.signature_base
      base[0].should == 'GET'
    end

    it "includes the request URL" do
      request = new_request(new_client, 'GET', 'http://example.com')
      base = request.signature_base
      URI.unescape(base[1]).should == 'http://example.com'
    end

    it "strips params from request URL" do
      request = new_request(new_client, 'GET', 'http://example.com/?foo=bar')
      base = request.signature_base
      URI.unescape(base[1]).should == 'http://example.com/'
    end

    it "strips anchor from request URL" do
      request = new_request(new_client, 'GET', 'http://example.com/#foo')
      base = request.signature_base
      URI.unescape(base[1]).should == 'http://example.com/'
    end

    it "includes path in request URL" do
      request = new_request(new_client, 'GET', 'http://example.com/foo')
      base = request.signature_base
      URI.unescape(base[1]).should == 'http://example.com/foo'
    end

    it "includes query_string" do
      client = new_client
      request = new_request(client, 'GET', 'http://example.com')
      base = request.signature_base
      URI.unescape(base[2]).should == request.query_string
    end
  end

  describe "signature" do
    it "joins signature_base with & and HMAC::SHA1 signs it with client key" do
      client = new_client
      client.should_receive(:key).and_return('abc')
      request = new_request(client)
      Base64.decode64(request.signature).should == HMAC::SHA1.digest('abc', request.signature_base.join('&'))
    end

    it "Base64 encodes and strips result" do
      client = new_client
      client.should_receive(:key).and_return('abc')
      request = new_request(client)
      request.signature.should == Base64.encode64(HMAC::SHA1.digest('abc', request.signature_base.join('&'))).strip
    end

    it "memoizes its result" do
      client = new_client
      client.should_receive(:key).once.and_return('abc')
      request = new_request(client)
      request.signature
      request.signature
    end
  end

  describe "sign!" do
    it "adds signature to params" do
      request = new_request
      request.sign!
      request.params['oauth_signature'].should == request.signature
    end

    it "only signs once" do
      request = new_request
      request.should_receive(:signature).once
      request.sign!
      request.sign!
    end
  end

  describe "signed?" do
    it "is true when the request has already been signed" do
      request = new_request
      request.should_not be_signed
      request.sign!
      request.should be_signed
    end
  end
end
