module Dmm
  class Error < StandardError
    ClientError = Class.new self
    ServerError = Class.new self
  end
end
