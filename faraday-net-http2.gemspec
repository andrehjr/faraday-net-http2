# frozen_string_literal: true

require_relative 'lib/faraday/net_http2/version'

Gem::Specification.new do |spec|
  spec.name = 'faraday-net-http2'
  spec.version = Faraday::NetHttp2::VERSION
  spec.authors = ['André Luis Leal Cardoso Junior']
  spec.email = ['andrehjr@gmail.com']

  spec.summary = 'Faraday adapter for NetHttp2'
  spec.description = 'Faraday adapter for NetHttp2'
  spec.homepage = 'https://github.com/andrehjr/faraday-net-http2'
  spec.license = 'MIT'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/andrehjr/faraday-net-http2'
  spec.metadata['changelog_uri'] = 'https://github.com/andrehjr/faraday-net-http2'

  spec.files = Dir.glob('lib/**/*') + %w[README.md LICENSE.md]
  spec.require_paths = ['lib']

  spec.add_dependency "faraday", [">= 1.10", "< 3"]
  spec.add_dependency "net-http2"
end
