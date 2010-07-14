module ULS
  class Request
    attr_reader :uri

    def initialize(client, method, uri)
      @client, @method, @uri = client, method, URI.parse(uri)
    end

    def sign!
      params.merge!('oauth_signature' => signature) unless signed?
    end

    def signed?
      params.has_key?('oauth_signature')
    end

    def nonce
      # This implementation is what is used in the oauth gem
      @nonce ||= Base64.encode64(OpenSSL::Random.random_bytes(32)).gsub(/\W/, '')
    end

    def timestamp
      @timestamp ||= Time.now.to_i.to_s
    end

    def signature
      @signature ||= begin
        sig = HMAC::SHA1.digest(@client.key, signature_base.join('&'))
        sig = Base64.encode64(sig)
        sig = sig.strip
        escape(sig)
      end
    end

    def params
      @params ||= begin
        parameters = @uri.query ? Rack::Utils.parse_query(@uri.query) : {}
        parameters.merge! @client.params
        parameters.merge! 'oauth_nonce' => escape(nonce)
        parameters.merge! 'oauth_timestamp' => escape(timestamp)
        parameters
      end
    end

    def signature_base
      base = []
      base << @method
      base << escape(@uri.scheme + '://' + @uri.host + @uri.path)
      base << escape(query_string)
      base
    end

    def query_string
      params.sort.inject([]) { |query, (key, val)|
        query << "#{key}=#{val}"
        query
      }.join('&')
    end

    private

    def escape(val)
      URI.escape(val, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end
  end
end
