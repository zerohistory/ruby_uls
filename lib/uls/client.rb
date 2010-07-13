module ULS
  class Client
    attr_accessor :consumer_key, :consumer_secret,
                  :application_token, :application_token_secret
    attr_reader :consumer_key, :consumer_secret,
                :application_token, :application_token_secret

    def initialize(credentials={})
      @consumer_key = credentials[:consumer_key]
      @consumer_secret = credentials[:consumer_secret]
      @application_token = credentials[:application_token]
      @application_token_secret = credentials[:application_token_secret]
    end
    end
  end
end
