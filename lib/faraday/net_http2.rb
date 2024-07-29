# frozen_string_literal: true

require_relative 'adapter/net_http2'
require_relative 'net_http2/version'

module Faraday
  module NetHttp2
    Faraday::Adapter.register_middleware(net_http2: Faraday::Adapter::NetHttp2)
  end
end
