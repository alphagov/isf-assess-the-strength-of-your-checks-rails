require 'time'

class Assessment < FormResponses
  def initialize(constructor = nil)
    super(constructor)
    self['_type'] = 'assessment'
    self['date_created'] = Time.now.utc.iso8601
  end

  def add_evidence(evidence)
    evidence_id_list << evidence.id
  end

  def evidence_id_list
    self['evidence'] ||= Array.new
  end
end
