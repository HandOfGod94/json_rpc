require 'json'

module JsonRpc
  class Response
    attr_reader :method, :result, :error, :id

    def initialize(method:, result:, id:, error: nil)
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

    def eql?(other)
      other.class == self.class && 
        other.method == method &&
        other.result == result &&
        other.error == error &&
        other.id == id
    end
    alias == eql?
    
    def hash
      [self.class, method, result, error, id].hash
    end
  end
end
