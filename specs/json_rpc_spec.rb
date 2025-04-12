require 'json_rpc'

describe 'JsonRpc' do
  describe '.invoke' do
    it 'invokes rpc and returns json rpc response' do
      router = JsonRpc::Router.define do
        rpc :ping do
          "pong"
        end
      end

      request = JsonRpc::Request.new(:ping, [], 1)
      result = JsonRpc.invoke(router, request)
      _(result).must_equal(JsonRpc::Response.new(method: :ping, result: "pong", id: 1))
    end
    it 'raises rpc not present error if rpc is absent'
  end
end
