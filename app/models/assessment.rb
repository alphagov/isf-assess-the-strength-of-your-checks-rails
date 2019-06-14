require 'time'

class Assessment < FormResponses
  ATTRS = %i[id date_created confidence_level_required
             evidence_id_list
             identity_exists_over_time identity_with_organisation_proved org_check_method org_activity_found activity_time_period
             identity_been_stolen_or_used_fraudulently check_identity_not_stolen_or_used_fraudulently counter_fraud_data_sources independent_counter_fraud_sources
             check_person_is_who_they_claim_to_be check_person_is_the_same_person_the_evidence_was_issued_to physically_matches_evidence detect_imposters
             refresh_training how_do_you_check_properly verification_system system_checks properly_see_person
             biometric_system_checks biometric_check_person_is_real protect_against_spoofing biometric_false_handled biometric_captured_under_controlled_conditions
             kbv_static_or_dynamic low_quality_kbv_challenges medium_quality_kbv_challenges high_quality_kbv_challenges
             kbv_multiple_or_single kbv_how_many_checks_multiple kbv_how_many_checks_single].freeze
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
