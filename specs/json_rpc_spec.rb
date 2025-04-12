require 'json_rpc'

describe 'JsonRpc' do
  describe '.invoke' do
    it 'invokes rpc and returns json rpc response' do
      router = JsonRpc::Router.define do
        rpc :ping do
          'pong'
        end
      end

      request = JsonRpc::Request.new(:ping, [], 1)
      result = JsonRpc.invoke(router, request)
      _(result).must_equal(JsonRpc::Response.new(method: :ping, result: 'pong', id: 1))
    end

    it 'returns error when the error is raised within rpc' do
      router = JsonRpc::Router.define do
        rpc :errored_rpc do
          raise StandardError
        end
      end

      request = JsonRpc::Request.new(:errored_rpc, [], 1)
      result = JsonRpc.invoke(router, request)

      _(result).must_equal(JsonRpc::Response.new(method: :errored_rpc,
                                                 result: nil,
                                                 error: 'StandardError',
                                                 id: 1))
    end

    it 'raises rpc not present error if rpc is absent'
  end
end
