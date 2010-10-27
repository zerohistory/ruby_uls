require 'rubygems'
begin
  require 'spec'
rescue LoadError
  require 'rspec'
end

require File.dirname(__FILE__) + '/../lib/ruby-uls'

def new_client(options={})
  ULS::Client.new({
    :consumer_key => "abcdefg1",
    :consumer_secret => "abcdefg2",
    :application_token => "abcdefg3",
    :application_token_secret => "abcdefg4"
  }.merge(options))
end

def new_request(client=new_client, method='POST', uri="http://example.com")
  ULS::Request.new(client, method, uri)
end
