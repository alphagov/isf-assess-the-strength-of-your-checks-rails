class Evidence < FormResponses
  def name
    self['evidence_type'] || self['evidence_type_other']
  end
end
