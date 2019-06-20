class CreateAssessments < ActiveRecord::Migration[5.2]
  def change
    create_table :assessments do |t|
      t.string :confidence_level_required
      t.string :identity_exists_over_time
      t.string :identity_with_organisation_proved
      t.string :org_check_method
      t.string :org_activity_found
      t.string :activity_time_period
      t.string :identity_been_stolen_or_used_fraudulently
      t.string :check_identity_not_stolen_or_used_fraudulently
      t.string :counter_fraud_data_sources
      t.string :independent_counter_fraud_sources
      t.string :check_person_is_who_they_claim_to_be
      t.string :check_person_is_the_same_person_the_evidence_was_issued_to
      t.string :physically_matches_evidence
      t.string :detect_imposters
      t.string :refresh_training
      t.string :how_do_you_check_properly
      t.string :verification_system
      t.string :system_checks
      t.string :properly_see_person
      t.string :biometric_system_checks
      t.string :biometric_check_person_is_real
      t.string :protect_against_spoofing
      t.string :biometric_false_handled
      t.string :biometric_captured_under_controlled_conditions
      t.string :kbv_static_or_dynamic
      t.string :low_quality_kbv_challenges
      t.string :medium_quality_kbv_challenges
      t.string :high_quality_kbv_challenges
      t.string :kbv_multiple_or_single
      t.string :kbv_how_many_checks_multiple
      t.string :kbv_how_many_checks_single
      t.timestamps
    end
  end
end
