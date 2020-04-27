# XpmRuby

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/xpm_ruby`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xpm_ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install xpm_ruby

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

### Testing with VCR
There are a few extra steps you need when writing VCR spec to avoid checking in sensitive data.
1. When writing a new VCR spec, you need to use the real api_key and account_key to hit the server
1. After you have generated the spec, change the api_key and account_key BEFORE CHECKING IT IN
1. Open up the cassette and ensure you have updated the Basic auth code as well (also before checking it in)
```
headers:
      Authorization:
      - Basic TEST
```
1. If needed you can also alter the body.string of the response

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/xpm_ruby.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
