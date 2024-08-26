# frozen_string_literal: true

RSpec.describe Faraday::Adapter::NetHttp2 do
  features :request_body_on_query_methods,
           :reason_phrase_parse,
           # :compression,
           :streaming,
           :trace_method

  it_behaves_like 'an adapter'

  context 'real requests' do
    let(:port) { 9516 }
    let(:server) { H2Server.new(port) }
    let(:base_url) { "http://localhost:#{port}" }

    let(:conn) do
      Faraday.new(url: base_url) do |faraday|
        faraday.adapter :net_http2
      end
    end

    before { server.listen }

    after do
      server.stop
    end

    context 'non streaming' do
      it 'makes an get request' do
        expect(conn.get('/').status).to be(200)
      end
    end

    context 'streaming' do
      it 'makes an get request' do
        body = String.new
        conn.get('/') do |req|
          req.options.on_data = proc do |chunk, size, block_env|
            body << chunk
          end
        end
        # wait for response
        sleep 0.1

        expect(body.to_s).to eql("Hello HTTP 2.0!")
      end
    end
  end
end
