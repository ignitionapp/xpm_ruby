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

## Rate limits

Xero returns its rate-limit headers on every XPM response, not only on the `429` that refuses one.
Set `XpmRuby.on_rate_limits` to be told about each reading:

```ruby
XpmRuby.on_rate_limits = ->(limits) do
  MyApp.record(
    tenant:      limits.xero_tenant_id,
    day_left:    limits.daylimit_remaining,
    minute_left: limits.minlimit_remaining,
    problem:     limits.problem
  )
end
```

The callback is handed an `XpmRuby::RateLimits` carrying `status`, `xero_tenant_id`, `problem`,
`retry_after` and the three remaining-budget counts. Counts are integers, and `nil` when the
response did not report one — a missing header is *not* read as zero, because zero means the budget
is exhausted and is the reading a caller most needs to act on. Responses that name no limit at all
do not invoke the callback.

Read from a `429` alone these headers can only say the budget is already gone. Read from every
response they let a caller stop short of the limit instead of discovering it.

Set the callback once, at boot. Every entry point in this gem builds its own `Connection` and never
hands it back, so the callback is what reaches them all. It must not raise: if it does, the error is
warned and the request it was measuring still succeeds.

`XpmRuby::RateLimitExceeded#details` still carries the raw wire-named header hash from the `429`
that raised it, unchanged for the lowercase headers Xero sends. It is now read case-insensitively,
so a change of casing at Xero's end can no longer empty it.

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
