class Response < Struct.new("Response",:status, :result, :errors)
  # attr_accessor :errors, :status, :result

  # def initialize(status: status_=nil, result: result_=nil, errors: errors_=nil)
  #   status = status_
  #   result = result_
  #   errors = errors_
  # end

  def fail?
    status == :fail
  end

  def success?
    status == :success
  end

  def success! result = nil
    self.status = :success
    self.result = result
    self
  end

  def fail! errors
    self.status = :fail
    self.errors = errors
    self
  end
end
