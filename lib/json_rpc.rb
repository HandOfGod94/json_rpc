require 'json_rpc/version'
require 'json_rpc/router'
require 'json_rpc/request'
require 'json_rpc/response'

module JsonRpc
  class MisconfiguredRoutesError < StandardError
  end

  class InvalidRequestBodyError < StandardError
  end
end
