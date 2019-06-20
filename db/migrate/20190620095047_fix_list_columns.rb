class FixListColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :assessments, :check_identity_not_stolen_or_used_fraudulently, :string
    add_column :assessments, :check_identity_not_stolen_or_used_fraudulently, :json

    remove_column :assessments, :org_check_method, :string
    add_column :assessments, :org_check_method, :json

    remove_column :assessments, :check_person_is_the_same_person_the_evidence_was_issued_to, :string
    add_column :assessments, :check_person_is_the_same_person_the_evidence_was_issued_to, :json

    remove_column :assessments, :how_do_you_check_properly, :string
    add_column :assessments, :how_do_you_check_properly, :json

    remove_column :assessments, :system_checks, :string
    add_column :assessments, :system_checks, :json

    remove_column :assessments, :biometric_system_checks, :string
    add_column :assessments, :biometric_system_checks, :json

    remove_column :assessments, :protect_against_spoofing, :string
    add_column :assessments, :protect_against_spoofing, :json

    remove_column :assessments, :biometric_false_handled, :string
    add_column :assessments, :biometric_false_handled, :json
  end
end
