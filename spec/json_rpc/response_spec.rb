require 'json_rpc'
require 'json'

describe 'Response' do
  describe '.to_json' do
    it 'returns json when data is valid' do
      response = JsonRpc::Response.new(method: :ping, result: 'fake-result', error: nil, id: 1)
      _(response.to_json).must_equal({
        method: :ping,
        result: 'fake-result',
        error: nil,
        id: 1
      }.to_json)
    end
  end

  describe '.error?' do
    it 'returns true if error is present' do
      response = JsonRpc::Response.new(method: :ping, result: nil, error: 'foobar', id: 1)
      _(response.error?).must_equal(true)
    end

    it 'returns false if error is absent' do
      response = JsonRpc::Response.new(method: :ping, result: 'fake-result', error: nil, id: 1)
      _(response.error?).must_equal(false)
    end
  end
end
