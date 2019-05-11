module DesignSystem
  # Collection of errors by component ID; optionally you can set a
  # heading.
  #
  # Errors may be retrieved in order (as required for the "Error summary"
  # component) or by key (as required to show individual error messages).
  class Errors < ActiveSupport::OrderedHash
    attr_accessor :heading
  end
end