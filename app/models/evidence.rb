class Evidence < FormResponses
  ATTRS = %i[id evidence_type evidence_type_other
             physical_check crypto_check authoritative_source_check cancellation_check].freeze
  attr_accessor(*ATTRS)
end
