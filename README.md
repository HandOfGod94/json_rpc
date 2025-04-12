# JSON-RPC

A lightweight, transport-agnostic JSON-RPC 1.0 implementation in Ruby that provides a simple way to handle JSON-RPC requests and responses.

> **Note:** This project is currently a work in progress. It implements JSON-RPC 1.0 specification and is being actively developed.

## Features

- Simple and clean API for handling JSON-RPC requests
- Built-in request validation
- Customizable routing system with yield-based DSL
- Error handling for common JSON-RPC scenarios
- Transport-agnostic design (works with HTTP, WebSocket, or any other transport layer)
- JSON-RPC 1.0 specification compliant

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_rpc'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install json_rpc
```

## Usage

```ruby
require 'json_rpc'

# Define your routes using the yield-based router
router = JsonRpc::Router.define do |r|
  r.rpc :add do |a, b|
    a + b
  end

  r.rpc :ping do
    'pong'
  end
end

# Handle a request using invoke
request = '{"jsonrpc": "1.0", "method": "add", "params": [1, 2], "id": 1}'
response = router.invoke(request)
puts response.to_json
# => {"jsonrpc":"1.0","result":3,"id":1}

# Handle a ping request
request = '{"jsonrpc": "1.0", "method": "ping", "params": [], "id": 2}'
response = router.invoke(request)
puts response.to_json
# => {"jsonrpc":"1.0","result":"pong","id":2}
```

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests.
