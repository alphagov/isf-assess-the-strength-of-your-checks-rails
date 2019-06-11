require 'time'

class Assessment < FormResponses
  ATTRS = %i[id date_created confidence_level_required
             evidence_id_list
             identity_exists_over_time identity_with_organisation_proved org_check_method org_activity_found activity_time_period
             identity_been_stolen_or_used_fraudulently check_identity_not_stolen_or_used_fraudulently counter_fraud_data_sources independent_counter_fraud_sources].freeze
  attr_accessor(*ATTRS)

  def initialize(attributes = {})
    super
    self.date_created = Time.now.utc.iso8601 if !self.date_created
  end

  def add_evidence(evidence)
    self.evidence_id_list << evidence.id
  end

  def evidence_id_list
    @evidence_id_list ||= Array.new
  end
end
