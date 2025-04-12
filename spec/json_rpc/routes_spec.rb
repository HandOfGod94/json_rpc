require 'json_rpc'

describe 'Routes' do
  describe 'configuration' do
    it 'configures routes correctly' do
      router = JsonRpc::Router.define do |r|
        r.rpc :ping do
          'pong'
        end

        r.rpc :echo do
          'echo server'
        end
      end

      _(router.has_rpc?(:ping)).must_equal(true)
      _(router.has_rpc?(:echo)).must_equal(true)
    end

    it 'raise if block is not given' do
      _ { JsonRpc::Router.define }.must_raise JsonRpc::MisconfiguredRoutesError
    end
  end

  describe '.invoke' do
    it 'invokes rpc and returns json rpc response' do
      router = JsonRpc::Router.define do |r|
        r.rpc :ping do
          'pong'
        end
      end

      request = '{"method": "ping", "params": [], "id":1}'
      result = router.invoke(request)
      _(result).must_equal(JsonRpc::Response.new(method: :ping, result: 'pong', id: 1))
    end

    it 'provides a way to pass params to json rpc' do
      router = JsonRpc::Router.define do |r|
        r.rpc :echo do |*params|
          params.inspect
        end
      end

      request = '{"method": "echo", "params": ["hello", "world"], "id":1}'
      result = router.invoke(request)
      _(result).must_equal(JsonRpc::Response.new(method: :echo, result: '["hello", "world"]', id: 1))
    end

    it 'returns error when the error is raised within rpc' do
      router = JsonRpc::Router.define do |r|
        r.rpc :errored_rpc do
          raise StandardError
        end
      end

      request = '{"method": "errored_rpc", "params": [], "id":1}'
      result = router.invoke(request)

      _(result).must_equal(JsonRpc::Response.new(method: :errored_rpc,
                                                 result: nil,
                                                 error: 'StandardError',
                                                 id: 1))
    end

    it 'raises rpc not present error if rpc is absent' do
      router = JsonRpc::Router.define do |r|
        r.rpc :ping do
          'pong'
        end
      end

      request = '{"method": "fizz", "params": [], "id":1}'
      result = router.invoke(request)
      _(result.result).must_be_nil
      _(result.error).wont_be_nil
      _(result.error).must_match(/undefined method `fizz'/)
    end
  end
end
