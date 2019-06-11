class Evidence < FormResponses
  ATTRS = %i[id evidence_type evidence_type_other].freeze
  attr_accessor(*ATTRS)

  def name
    self.evidence_type || self.evidence_type_other
  end
end
