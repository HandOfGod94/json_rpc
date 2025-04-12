module JsonRpc
  class Router
    attr_reader :routes

    def initialize
      @routes = {}
    end

		def rpc(method, &block)
			@routes[method] = block if block_given?
			self
		end

		def fetch_handler(method)
			@routes[method]
		end

		def has_rpc?(method)
			@routes.key?(method)
		end

		class << self 
			def define(&block)
				raise JsonRpc::MisconfiguredRoutesError unless block_given?

				router = Router.new
				router.instance_eval &block
			end
		end
  end
end
