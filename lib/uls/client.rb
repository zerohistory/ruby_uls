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

    def post(uri)
      request = Request.new(self, 'POST', uri)
      request.sign!

      uri = request.uri
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Post.new(uri.request_uri, { 'Accept' => 'application/json' })
      req.set_form_data(request.params)
      res = http.request(req).body
      JSON.parse(res)
    end

    def get(uri)
      request = Request.new(self, 'GET', uri)
      request.sign!
      uri = request.uri
      uri = uri.scheme + '://' + uri.host + uri.path + "?" + request.query_string
      res = open(uri, 'Accept' => 'application/json').read
      JSON.parse(res)
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
