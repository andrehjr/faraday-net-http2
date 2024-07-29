# frozen_string_literal: true

RSpec.describe Faraday::Adapter::NetHttp2 do
  features :request_body_on_query_methods,
           :reason_phrase_parse
           # TODO
           # :compression, 
           # :streaming,
           # :trace_method

  it_behaves_like 'an adapter'
end
