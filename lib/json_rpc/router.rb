module JsonRpc
  class Router
    class << self
      def define
        raise JsonRpc::MisconfiguredRoutesError unless block_given?

        router = Router.new
        yield router
        router
      end
    end

    def initialize
      @rpc_methods = Module.new
      extend(@rpc_methods)
    end

    def rpc(method, &block)
      @rpc_methods.define_method(method, &block) if block_given?
      self
    end

    def has_rpc?(method) = respond_to?(method)

    def invoke(raw_request)
      request = JsonRpc::Request.from_json!(raw_request)
      result = send(request.method, *request.params)
      JsonRpc::Response.new(id: request.id, result: result, method: request.method)
    rescue StandardError => e
      JsonRpc::Response.new(id: request.id, result: nil, error: e.message, method: request.method)
    end
  end
end
