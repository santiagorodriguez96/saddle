require 'faraday'
require 'typhoeus'


class Requester

  # Available options
  ## host - host to connect to (default: localhost)
  ## port - port to connect on (default: 80)
  ## use_ssl - true if we should use https
  def initialize(opt={})
    @host = opt[:host] || 'localhost'
    @port = opt[:port] || 80
    @use_ssl = opt[:use_ssl]  || false
  end

  def get(url, params)
    connection.get do |request|
      request.url(url, params)
    end
  end

  def post(url, params)
    connection.get do |request|
      request.url(url, params)
    end
  end



  private

  def connection
    @connection ||= Faraday.connection.new(
      :url => "http#{'s' if @use_ssl}://#{@host}:#{@port}",
      :headers => {
        :accept => 'application/json'
      }
    ) do |faraday|
      faraday.request(:url_encoded) # form-encode POST params
      faraday.adapter(:typhoeus)    # make requests with Typhoeus
    end
  end

end
