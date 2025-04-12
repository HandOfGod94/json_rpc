require 'json'

module JsonRpc
  class Request
    attr_reader :method, :params, :id

    def initialize(method, params, id)
      @method = method
      @params = params
      @id = id
    end

    def self.from_json!(raw)
      map = JSON.parse!(raw)
      raise JsonRpc::InvalidRequestBodyError unless map.has_key?('method')
      raise JsonRpc::InvalidRequestBodyError unless map.has_key?('params')
      raise JsonRpc::InvalidRequestBodyError unless map.has_key?('id')

      Request.new(map['method'].to_sym, map['params'], map['id'])
    end
  end
end
