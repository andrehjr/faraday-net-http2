# frozen_string_literal: true

require_relative 'adapter/net_http2'
require_relative 'net_http2/version'

module Faraday
  module NetHttp2
    # Faraday allows you to register your middleware for easier configuration.
    # This step is totally optional, but it basically allows users to use a custom symbol (in this case, `:my_adapter`),
    # to use your adapter in their connections.
    # After calling this line, the following are both valid ways to set the adapter in a connection:
    # * conn.adapter Faraday::Adapter::NetHttp2
    # * conn.adapter :net_http2
    # Without this line, only the former method is valid.
    Faraday::Adapter.register_middleware(net_http2: Faraday::Adapter::NetHttp2)
  end
end
