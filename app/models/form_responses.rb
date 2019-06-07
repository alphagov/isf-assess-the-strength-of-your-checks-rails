# Base class for (non-ActiveRecord) models providing serialization and attribute access
class FormResponses
  include ActiveModel::Model
  include ActiveModel::Serialization

  # Derived classes should provide ATTRS (a list of field name symbols), this is
  # necessary for our serialization process (see #attributes).
  #
  # Background https://guides.rubyonrails.org/active_model_basics.html
  #            https://api.rubyonrails.org/classes/ActiveModel/Model.html
  #            https://api.rubyonrails.org/classes/ActiveModel/Serialization.html

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

  # attributes= is handled for us by ActiveModel::Model
end
