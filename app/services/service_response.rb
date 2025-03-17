class ServiceResponse
  attr_reader :object, :errors

  def initialize(object, errors = nil)
    @object = object
    @errors = errors
  end

  def success?
    errors.nil?
  end
end