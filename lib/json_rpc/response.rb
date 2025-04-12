require 'json'

module JsonRpc
  class Response
    attr_reader :method, :result, :error, :id

    def initialize(method:, result:, error:, id:)
      @method = method
      @result = result
      @error = error
      @id = id
    end

    def to_json(*_args)
      {
        method: method,
        result: result,
        error: error,
        id: id
      }.to_json
    end

		def error? = !error.nil?
  end
end
