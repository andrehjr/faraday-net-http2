# Faraday NetHttp2 Adapter

This is an initial implementation of a [Faraday 2][faraday] adapter for the [NetHttp2][net-http2] HTTP client.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faraday-net-http2'
```

And then execute:

    $ bundle install

Or install it yourself with `gem install faraday-net-http2` and require it in your ruby code with `require 'faraday/net-http2'`

## Usage

### Basic

```ruby
conn = Faraday.new(...) do |f|
  f.adapter :net_http2
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](rubygems).

### TODO

- [ ] Enable all possible faraday features on spec/faraday/adapter/net_http2_spec.rb.
- [ ] Streaming support?
- [ ] Review custom webmock adapter, and maybe push it back to the main repo

## Contributing

Bug reports and pull requests are welcome on [GitHub][repo].

## License

The gem is available as open source under the terms of the [license][license].

[faraday]: https://github.com/lostisland/faraday
[net-http2]: https://github.com/ostinelli/net-http2
[repo]: https://github.com/andrehjr/faraday-net-http2
[license]: LICENSE.md
