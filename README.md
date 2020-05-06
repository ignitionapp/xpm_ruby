# XpmRuby

This gem is used to access Xero's XPM api.

You will need to install and manage the access_tokens with Oauth 2.0 in your own app.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "xpm_ruby", git: "https://github.com/ignitionapp/xpm_ruby"
```

And then execute:

    $ bundle install

## Usage

Most of the API calls will require at least the two main following arguments

1. `access_token` - the oauth2 access token (Oauth2 is not included here)
1. `xero_tenant_id` - You get this by calling the xero api connection. See https://github.com/ignitionapp/xpm_ruby_demo/blob/master/subdomains/xpm_integration/access_token.rb for more details.

Handling the refresh token and logging into Xero should all take place in the main app. The sample app is available at https://github.com/ignitionapp/xpm_ruby_demo

Most of the time, you will be passing in a hash representation of the object you are working with (with one or two exceptions where it might be an ID or raw XML).

The gem will convert the hash into the XML needed by the XPM api. The data that is returned will automatically be converted from XML to a Ruby Hash or Array.

For example, a call to `XPMRuby::Staff.list(access_token: access_token, xero_tenant_id: xero_tenant_id)` will return an array of hashes representing the staff list.

```ruby
[
    { "ID" => "859230", "Name" => "Dev Testing", "Email" => "dev@practiceignition.com", "Phone" => nil, "Mobile" => nil, "Address" => nil, "PayrollCode" => nil },
    ...
]
```

As much as possible, we have tried to keep to the same names as documented here: https://developer.xero.com/documentation/practice-manager/overview-practice-manager-api however we have not as yet added the full API (only the endpoints we are currently using in ignitionapp).

## Development

TODO set up this gem to release automatically when merged into master...

Note: This gem is not released yet and is currently for internal use.

Please refer to it via github for now
e.g.
`gem "xpm_ruby", git: "https://github.com/ignitionapp/xpm_ruby"`

## Testing
Rspec is used for testing

`bundle exec rspec`

In addition, rubocop is installed to check formatting and code quality

`bundle exec rubocop`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ignitionapp/xpm_ruby.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
