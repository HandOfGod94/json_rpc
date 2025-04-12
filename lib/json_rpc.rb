require 'json_rpc/version'
require 'json_rpc/router'
require 'json_rpc/request'
require 'json_rpc/response'

module JsonRpc
  class MisconfiguredRoutesError < StandardError
  end

  class InvalidRequestBodyError < StandardError
  end

  def invoke(router, request)
    result = router.fetch_handler(request.method).call
    JsonRpc::Response.new(id: request.id, result: result, method: request.method)
  end

  module_function :invoke
end
