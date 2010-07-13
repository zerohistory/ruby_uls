module ULS
  class Client
    attr_accessor :consumer_key, :consumer_secret,
                  :application_token, :application_token_secret

    def initialize(credentials={})
      credentials.each { |key, val| send("#{key}=", val) }
    end
  end
end
