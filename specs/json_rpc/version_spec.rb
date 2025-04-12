require "minitest/autorun"
require "json_rpc"

describe "version" do
	it "matches the exact version" do
		_(JsonRpc::Version::VERSION).must_equal("0.1.0")
	end
end