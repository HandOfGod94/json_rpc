require "json_rpc/version.rb"
require "json_rpc/router.rb"
require "json_rpc/response.rb"
require "json_rpc/request.rb"

module JsonRpc
	class MisconfiguredRoutesError < StandardError
	end
	
	class InvalidRequestBodyError < StandardError
	end
end