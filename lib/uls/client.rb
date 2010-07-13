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

    def nonce
      # This implementation is what is used in the oauth gem
      Base64.encode64(OpenSSL::Random.random_bytes(32)).gsub(/\W/, '')
    end

    def timestamp
      Time.now.to_i.to_s
    end
  end
end
