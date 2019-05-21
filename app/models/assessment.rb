class Assessment < FormResponses
  def add_evidence(evidence)
    evidence_id_list << evidence.id
  end

  def evidence_id_list
    self['evidence'] ||= Array.new
  end
end
