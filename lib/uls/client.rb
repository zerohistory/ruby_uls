module ULS
  class Client
    attr_reader :consumer_key, :consumer_secret,
                :application_token, :application_token_secret

    def initialize(credentials={})
      @consumer_key = credentials[:consumer_key]
      @consumer_secret = credentials[:consumer_secret]
      @application_token = credentials[:application_token]
      @application_token_secret = credentials[:application_token_secret]
    end

    def key
      escape(@consumer_secret) + '&' + escape(@application_token_secret)
    end

    def params
      @params ||= {
        'oauth_consumer_key'  => escape(@consumer_key),
        'oauth_token'         => escape(@application_token),
        'oauth_signature_method' => 'HMAC-SHA1'
      }
    end

    private

    def escape(val)
      URI.escape(val, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end
  end
end
