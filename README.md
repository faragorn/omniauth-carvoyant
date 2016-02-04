# OmniAuth Carvoyant OAuth2 Strategy

Strategy to authenticate with Carvoyant via OAuth2 in OmniAuth.

Register for you developer account at: https://developer.carvoyant.com/member/register Note the Client ID and Client Secret.

For more details read Carvoyant docs: https://developer.carvoyant.com/page

## Installation

Add to your `Gemfile`:

```ruby
gem 'omniauth-carvoyant'
```

And then execute:

    $ bundle

## Usage

Here's an example for adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :carvoyant, ENV["CARVOYANT_CLIENT_ID"], ENV["CARVOYANT_CLIENT_SECRET"]
end
```

You can now access the OmniAuth Carvoyant OAuth2 URL: `/auth/carvoyant`

## Configuration

You can configure several options, which you pass in to the `provider` method via a hash:

* `callback_path`: Custom call back uri. Default is `/auth/carvoyant/callback`
* `name`: Custom strategy name. Default is `carvoyant` but it can be changed to any value, for example `carvoyant-api`. The OmniAuth URL will thus change to `/auth/carvoyant-api` and the `provider` key in the auth hash will then return `carvoyant-api`.

Here is an example of custom configuration with strategy name and callback uri changed:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :carvoyant, ENV["CARVOYANT_CLIENT_ID"], ENV["CARVOYANT_CLIENT_SECRET"],
  {
    :name => 'carvoyant1',
    :callback_path => 'carvoyant/callback'
  }
end
```

## Auth Hash

Here's an example of an authentication hash available in the callback by accessing `request.env["omniauth.auth"]`:

```ruby
{
    :provider => "carvoyant",
    :uid => "123456789",
    :info => {
        :name => "John Doe",
        :email => "john@company_name.com",
        :first_name => "John",
        :last_name => "Doe",
        :username => "john.doe"
    },
    :credentials => {
        :token => "token",
        :refresh_token => "another_token",
        :expires_at => 1354920555,
        :expires => true
    }
}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/faragorn/omniauth-carvoyant.


## License

Copyright (c) 2015 by Farrukh Abdulkadyrov

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
