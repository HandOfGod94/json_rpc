require "json_rpc"

describe "Routes" do 
	describe "configuration" do 
		it "configures routes correctly" do
			router = JsonRpc::Router.define do
				rpc :ping do
					"pong"
				end

				rpc :echo do
					"echo server"
				end
			end

			_(router.has_rpc?(:ping)).must_equal(true)
			_(router.has_rpc?(:echo)).must_equal(true)
		end

		it "raise if block is not given" do 
			_{ JsonRpc::Router.define }.must_raise JsonRpc::MisconfiguredRoutesError
		end
	end

	describe ".call!" do
		it "invokes rpc and returns json rpc response"
		it "raises rpc not present error if rpc is absent"
	end
end