$LOAD_PATH << File.dirname(__FILE__)

require 'base64'
require 'openssl'
require 'open-uri'
require 'hmac/sha1'
require 'rack/utils'
require 'net/https'

require 'uls/client'
require 'uls/request'

module ULS
  USER_DISCOVERY_URL = 'https://veriplace.com/api/1.1/invitations?mobile='

  def self.authenticate(phone_number, options={})
    @client.post(USER_DISCOVERY_URL + phone_number)
  end
end
