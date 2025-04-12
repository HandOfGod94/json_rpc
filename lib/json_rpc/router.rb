module JsonRpc
  class Router
    class << self
      def define(&block)
        raise JsonRpc::MisconfiguredRoutesError unless block_given?

        router = Router.new
        router.instance_eval(&block)
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

    def invoke(request)
      result = send(request.method, *request.params)
      JsonRpc::Response.new(id: request.id, result: result, method: request.method)
    rescue StandardError => e
      JsonRpc::Response.new(id: request.id, result: nil, error: e.message, method: request.method)
    end
  end
end
