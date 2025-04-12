module JsonRpc
  class Router
    class << self
      def define(&block)
        raise JsonRpc::MisconfiguredRoutesError unless block_given?

        router = Router.new
        router.instance_eval(&block)
      end
    end

    attr_reader :routes

    def initialize
      @routes = {}
    end

    def rpc(method, &block)
      @routes[method] = block if block_given?
      self
    end

    def has_rpc?(method)
      @routes.key?(method)
    end

    def invoke(request)
      result = fetch_handler(request.method).call
      JsonRpc::Response.new(id: request.id, result: result, method: request.method)
    rescue StandardError => e
      JsonRpc::Response.new(id: request.id, result: nil, error: e.message, method: request.method)
    end

    private

    def fetch_handler(method) = routes[method]
  end
end
