$LOAD_PATH << File.dirname(__FILE__)

require 'base64'
require 'openssl'
require 'open-uri'
require 'hmac-sha1'
require 'rack/utils'
require 'net/https'
require 'json'

require 'uls/client'
require 'uls/request'

module ULS
  USER_DISCOVERY_URL = 'https://veriplace.com/api/1.1/invitations?mobile='

  def self.invite(phone_number, options={})
    uri = USER_DISCOVERY_URL + phone_number
    uri << "&callback=#{options[:callback]}" if options[:callback]
    doc = client.post(uri)
    case
    when doc['oauth_error_code']
      raise "Error: #{doc.inspect}"
    when user = doc['user']
      { :user_id => user['id'] }
    when
      { :nonce => doc['value'] }
    else
      raise "Unknown Response: #{res}"
    end
  end

  def self.query_invite(nonce)
    client.get("https://veriplace.com/api/1.0/requests/#{nonce}")
  end

  def self.locate(user_id, options={})
    (callback = options[:callback]) ?
      client.post("https://veriplace.com/api/1.1/request/users/#{user_id}/locations?callback=#{callback}") :
      client.post("https://veriplace.com/api/1.1/users/#{user_id}/locations")
  end

  def self.permissions
    client.get("https://veriplace.com/api/1.1/permissions")
  end

  def self.client
    @client ||= Client.new \
      :consumer_key => ENV['ULS_CONSUMER_KEY'],
      :consumer_secret => ENV['ULS_CONSUMER_SECRET'],
      :application_token => ENV['ULS_APPLICATION_TOKEN'],
      :application_token_secret => ENV['ULS_APPLICATION_TOKEN_SECRET']
  end
end
