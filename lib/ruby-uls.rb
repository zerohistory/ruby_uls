$LOAD_PATH << File.dirname(__FILE__)

require 'base64'
require 'openssl'
require 'open-uri'
require 'hmac/sha1'
require 'rack/utils'
require 'net/https'
require 'nokogiri'

require 'uls/client'
require 'uls/request'

module ULS
  USER_DISCOVERY_URL = 'https://veriplace.com/api/1.1/invitations?mobile='

  def self.invite(phone_number, options={})
    uri = USER_DISCOVERY_URL + phone_number
    uri << "&callback=#{options[:callback]}" if options[:callback]
    res = client.post(uri)
    doc = Nokogiri(res)
    case
    when user = doc.at('user')
      { :user_id => user['id'] }
    when
      { :nonce => doc.at('nonce')['value'] }
    else
      raise "Unknown Response: #{res}"
    end
  end

  def self.query_invite(nonce)
    client.get("https://veriplace.com/api/1.0/requests/#{nonce}")
  end

  def self.client
    @client ||= Client.new \
      :consumer_key => ENV['ULS_CONSUMER_KEY'],
      :consumer_secret => ENV['ULS_CONSUMER_SECRET'],
      :application_token => ENV['ULS_APPLICATION_TOKEN'],
      :application_token_secret => ENV['ULS_APPLICATION_TOKEN_SECRET']
  end
end
