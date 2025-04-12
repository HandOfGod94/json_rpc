# The JsonRpc module provides a lightweight, transport-agnostic implementation of JSON-RPC 1.0 specification.
# It allows you to handle JSON-RPC requests and responses without being tied to any specific transport layer
# (HTTP, WebSocket, etc.), making it flexible for various use cases.
#
# == Basic Usage
#
#   require 'json_rpc'
#
#   # Define your RPC methods
#   router = JsonRpc::Router.define do
#     rpc :add do |a, b|
#       a + b
#     end
#   end
#
#   # Handle a request
#   request = '{"jsonrpc": "1.0", "method": "add", "params": [1, 2], "id": 1}'
#   response = router.invoke(request)
#
# == Components
#
# The module consists of several key components:
#
# * JsonRpc::Router - Handles method routing and invocation
# * JsonRpc::Request - Represents and validates incoming requests
# * JsonRpc::Response - Formats responses according to JSON-RPC 1.0 spec
#
# == Error Handling
#
# The module defines two custom error classes:
#
# * JsonRpc::MisconfiguredRoutesError - Raised when routes are not properly configured
# * JsonRpc::InvalidRequestBodyError - Raised when request body is invalid
#
# == Transport Agnosticism
#
# This implementation is transport-agnostic, meaning it doesn't care how the JSON-RPC messages
# are transmitted. You can use it with:
#
# * HTTP servers
# * WebSocket connections
# * Message queues
# * Any other transport mechanism
#
# The only requirement is that you pass a valid JSON string to the Router#invoke method.
#
# == JSON-RPC 1.0 Compliance
#
# This implementation follows the JSON-RPC 1.0 specification, which means:
#
# * Methods are invoked by name
# * Parameters are passed as an array
# * Each request must have an ID
# * Responses include the same ID as the request
# * Error responses include an error message
#
# @see https://www.jsonrpc.org/specification_v1
module JsonRpc
  # Raised when routes are not properly configured, typically when no block is provided
  # to Router.define.
  #
  # @example
  #   begin
  #     JsonRpc::Router.define # No block provided
  #   rescue JsonRpc::MisconfiguredRoutesError => e
  #     puts "Routes must be configured with a block"
  #   end
  class MisconfiguredRoutesError < StandardError
  end

  # Raised when the request body is invalid or cannot be parsed as JSON.
  #
  # @example
  #   begin
  #     router.invoke("invalid json") # Invalid JSON string
  #   rescue JsonRpc::InvalidRequestBodyError => e
  #     puts "Request body must be valid JSON"
  #   end
  class InvalidRequestBodyError < StandardError
  end
end

require 'json_rpc/version'
require 'json_rpc/router'
require 'json_rpc/request'
require 'json_rpc/response'
