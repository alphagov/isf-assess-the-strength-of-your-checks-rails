# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_06_25_120409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessments", force: :cascade do |t|
    t.string "confidence_level_required"
    t.string "identity_exists_over_time"
    t.string "identity_with_organisation_proved"
    t.string "org_activity_found"
    t.string "activity_time_period"
    t.string "identity_been_stolen_or_used_fraudulently"
    t.string "counter_fraud_data_sources"
    t.string "independent_counter_fraud_sources"
    t.string "check_person_is_who_they_claim_to_be"
    t.string "physically_matches_evidence"
    t.string "detect_imposters"
    t.string "refresh_training"
    t.string "verification_system"
    t.string "properly_see_person"
    t.string "biometric_check_person_is_real"
    t.string "biometric_captured_under_controlled_conditions"
    t.string "kbv_static_or_dynamic"
    t.string "low_quality_kbv_challenges"
    t.string "medium_quality_kbv_challenges"
    t.string "high_quality_kbv_challenges"
    t.string "kbv_multiple_or_single"
    t.string "kbv_how_many_checks_multiple"
    t.string "kbv_how_many_checks_single"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "check_identity_not_stolen_or_used_fraudulently"
    t.json "org_check_method"
    t.json "check_person_is_the_same_person_the_evidence_was_issued_to"
    t.json "how_do_you_check_properly"
    t.json "system_checks"
    t.json "biometric_system_checks"
    t.json "protect_against_spoofing"
    t.json "biometric_false_handled"
  end

  create_table "evidence", force: :cascade do |t|
    t.string "evidence_type"
    t.string "evidence_type_other"
    t.string "physical_check"
    t.string "crypto_check"
    t.string "authoritative_source_check"
    t.string "cancellation_check"
    t.bigint "assessment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "physical_original_check"
    t.string "physical_errors_check"
    t.string "digital_tool_used"
    t.string "digital_tool_follows_standard"
    t.string "checker_trained"
    t.string "checker_training_frequency"
    t.string "official_templates_used"
    t.string "official_templates_update_frequency"
    t.string "expiry_check"
    t.string "replay_attack_check"
    t.string "visible_features_check"
    t.string "visible_tamper_check"
    t.json "visible_features"
    t.string "visible_features_consistency"
    t.json "visible_features_equipment"
    t.string "visible_features_controlled_conditions"
    t.string "visible_features_supervision"
    t.string "uv_ir_features_check"
    t.json "uv_ir_features"
    t.json "crypto_features"
    t.index ["assessment_id"], name: "index_evidence_on_assessment_id"
  end

end
