require 'json_rpc'

describe 'Request' do
  describe '.from_json!' do
    it 'raises InvalidRequestBodyError if the given request body is invalid' do
      raw = <<-HEREDOC
      {"foo": "bar"}
      HEREDOC

      _ { JsonRpc::Request.from_json!(raw) }.must_raise JsonRpc::InvalidRequestBodyError
    end

    it 'converts from json to request object' do
      raw = <<-HEREDOC
      { "method": "echo", "params": ["Hello JSON-RPC"], "id":1 }
      HEREDOC

      result = JsonRpc::Request.from_json!(raw)
      _(result.method).must_equal(:echo)
      _(result.params).must_equal(['Hello JSON-RPC'])
      _(result.id).must_equal(1)
    end
  end
end
