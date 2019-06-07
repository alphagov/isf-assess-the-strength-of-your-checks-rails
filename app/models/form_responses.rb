class FormResponses
  include ActiveModel::Model
  include ActiveModel::Serialization

  ATTRS = [:id].freeze
  attr_accessor(*ATTRS)

  def initialize(attributes = {})
    # filter out invalid / no-longer valid fields from data (eg coming from the session)
    attributes.keep_if { |k, _| self.class::ATTRS.include? k.to_sym }
    super
    self.id = SecureRandom.uuid if !self.id
  end

  def attributes
    all = Hash.new
    self.class::ATTRS.each { |attribute| all[attribute] = nil }
    all
  end
end
