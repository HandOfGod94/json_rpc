require 'json_rpc'

describe 'Request' do
  describe '.from_json!' do
    it 'raises InvalidRequestBodyError if the given request body is invalid' do
      cases = [
        '{"foo": "bar"}',
        '{"method": "echo", "id":1}',
        '{"params": ["foobar"], "id":1}',
        '{"method": "echo", "params": ["foobar"]}'
      ]

      cases.each do |c|
        _ { JsonRpc::Request.from_json!(c) }.must_raise JsonRpc::InvalidRequestBodyError
      end
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
