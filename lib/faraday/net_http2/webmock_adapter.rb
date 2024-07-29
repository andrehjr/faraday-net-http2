# frozen_string_literal: true

require 'webmock'

module WebMock
  module HttpLibAdapters
    class WebMockNetHttp2Client < NetHttp2::Client

      def call(method, path, options={})
        request = prepare_request(method, path, options)

        request_signature = WebMock::RequestSignature.new method, request.uri, body: request.body, headers: request.headers
        WebMock::RequestRegistry.instance.requested_signatures.put(request_signature)

        if (mock_response = WebMock::StubRegistry.instance.response_for_request(request_signature))
          raise Errno::ETIMEDOUT if mock_response.should_timeout
          response = NetHttp2::Response.new(
            headers: { ":status" => mock_response.status[0] }.merge(mock_response.headers || {}),
            body:    mock_response.body
          )

          WebMock::CallbackRegistry.invoke_callbacks({ lib: :net_http2 }, request_signature, mock_response)
          response
        elsif WebMock.net_connect_allowed?(request_signature.uri)
          super
        else
          raise WebMock::NetConnectNotAllowedError, request_signature
        end
      end
    end

    class NetHttp2Adapter < WebMock::HttpLibAdapter
      adapter_for :net_http2

      OriginalNetHttp2Client = ::NetHttp2::Client unless const_defined?(:OriginalNetHttp2Client)

      def self.enable!
        ::NetHttp2.send(:remove_const, :Client)
        ::NetHttp2.send(:const_set, :Client, WebMockNetHttp2Client)
      end

      def self.disable!
        ::NetHttp2.send(:remove_const, :Client)
        ::NetHttp2.send(:const_set, :Client, OriginalNetHttp2Client)
      end
    end
  end
end