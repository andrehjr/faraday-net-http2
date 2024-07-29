# frozen_string_literal: true

RSpec.describe Faraday::NetHttp2 do
  it 'has a version number' do
    expect(Faraday::NetHttp2::VERSION).to be_a(String)
  end
end
