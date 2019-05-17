class FormResponses < ActiveSupport::HashWithIndifferentAccess
  def initialize(constructor = nil)
    self[:id] = SecureRandom.uuid if constructor.nil?
    super(constructor)
  end

  def id
    self[:id]
  end
end
