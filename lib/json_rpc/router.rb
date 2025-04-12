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

		def has_rpc?(method)
			@routes.key?(method)
		end

		class << self 
			def define(&block)
				router = Router.new
				router.instance_eval &block
			end
		end
  end
end
