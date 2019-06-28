Rails.application.routes.draw do
  root 'home#index'

  get 'assessments/new', to: 'assessments#new'
  post 'assessments', to: 'assessments#create'

  get 'assessments/:assessment_id/overview', to: 'assessments#overview'

  match 'assessments/:assessment_id/your-risk', to: 'assessment_questions#your_risk', via: %i[get post]
  get 'assessments/:assessment_id/no-risk', to: 'assessment_questions#no_risk'

  match 'assessments/:assessment_id/evidence/:evidence_id/choose-evidence', to: 'evidence_questions#choose_evidence', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/custom-strength', to: 'evidence_questions#custom_strength', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-0', to: 'evidence_questions#validity_physical_0', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-1a', to: 'evidence_questions#validity_physical_1a', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-1b', to: 'evidence_questions#validity_physical_1b', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-2a', to: 'evidence_questions#validity_physical_2a', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-2b', to: 'evidence_questions#validity_physical_2b', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-3a', to: 'evidence_questions#validity_physical_3a', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-3b', to: 'evidence_questions#validity_physical_3b', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-4a', to: 'evidence_questions#validity_physical_4a', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-4b', to: 'evidence_questions#validity_physical_4b', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-5', to: 'evidence_questions#validity_physical_5', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-physical-6', to: 'evidence_questions#validity_physical_6', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-visible-0', to: 'evidence_questions#validity_visible_0', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-visible-1', to: 'evidence_questions#validity_visible_1', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-visible-2', to: 'evidence_questions#validity_visible_2', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-visible-3', to: 'evidence_questions#validity_visible_3', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-visible-4', to: 'evidence_questions#validity_visible_4', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-visible-5', to: 'evidence_questions#validity_visible_5', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-visible-6', to: 'evidence_questions#validity_visible_6', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-uv-ir-0', to: 'evidence_questions#validity_uv_ir_0', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-uv-ir-1', to: 'evidence_questions#validity_uv_ir_1', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-crypto-0', to: 'evidence_questions#validity_crypto_0', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/validity-crypto-1', to: 'evidence_questions#validity_crypto_1', via: %i[get post]

  match 'assessments/:assessment_id/evidence/:evidence_id/issuance', to: 'evidence_questions#issuance', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/revocation', to: 'evidence_questions#revocation', via: %i[get post]
  get 'assessments/:assessment_id/evidence/:evidence_id/result', to: 'evidence_questions#evidence_result_get'
  post 'assessments/:assessment_id/evidence/:evidence_id/result', to: 'evidence_questions#evidence_result_post'

  match 'assessments/:assessment_id/activity-start', to: 'activity_questions#activity_start', via: %i[get post]
  match 'assessments/:assessment_id/activity-1', to: 'activity_questions#activity_1', via: %i[get post]
  match 'assessments/:assessment_id/activity-2', to: 'activity_questions#activity_2', via: %i[get post]
  match 'assessments/:assessment_id/activity-3', to: 'activity_questions#activity_3', via: %i[get post]
  get 'assessments/:assessment_id/activity-result', to: 'activity_questions#activity_result_get'
  post 'assessments/:assessment_id/activity-result', to: 'activity_questions#activity_result_post'

  match 'assessments/:assessment_id/fraud-start', to: 'fraud_questions#fraud_start', via: %i[get post]
  match 'assessments/:assessment_id/fraud-1', to: 'fraud_questions#fraud_1', via: %i[get post]
  match 'assessments/:assessment_id/fraud-2', to: 'fraud_questions#fraud_2', via: %i[get post]
  match 'assessments/:assessment_id/fraud-3', to: 'fraud_questions#fraud_3', via: %i[get post]
  get 'assessments/:assessment_id/fraud-result', to: 'fraud_questions#fraud_result_get'
  post 'assessments/:assessment_id/fraud-result', to: 'fraud_questions#fraud_result_post'

  match 'assessments/:assessment_id/verification-start', to: 'verification_questions#verification_start', via: %i[get post]
  match 'assessments/:assessment_id/verification-1', to: 'verification_questions#verification_1', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-1', to: 'verification_questions#verification_physical_1', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-2a', to: 'verification_questions#verification_physical_2a', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-2b', to: 'verification_questions#verification_physical_2b', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-2c', to: 'verification_questions#verification_physical_2c', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-3a', to: 'verification_questions#verification_physical_3a', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-3b', to: 'verification_questions#verification_physical_3b', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-3c', to: 'verification_questions#verification_physical_3c', via: %i[get post]
  match 'assessments/:assessment_id/verification-biometric-1', to: 'verification_questions#verification_biometric_1', via: %i[get post]
  match 'assessments/:assessment_id/verification-biometric-2', to: 'verification_questions#verification_biometric_2', via: %i[get post]
  match 'assessments/:assessment_id/verification-biometric-3', to: 'verification_questions#verification_biometric_3', via: %i[get post]
  match 'assessments/:assessment_id/verification-biometric-4', to: 'verification_questions#verification_biometric_4', via: %i[get post]
  match 'assessments/:assessment_id/verification-biometric-5', to: 'verification_questions#verification_biometric_5', via: %i[get post]
  match 'assessments/:assessment_id/verification-kbv-1', to: 'verification_questions#verification_kbv_1', via: %i[get post]
  match 'assessments/:assessment_id/verification-kbv-2a', to: 'verification_questions#verification_kbv_2a', via: %i[get post]
  match 'assessments/:assessment_id/verification-kbv-2b', to: 'verification_questions#verification_kbv_2b', via: %i[get post]
  match 'assessments/:assessment_id/verification-kbv-2c', to: 'verification_questions#verification_kbv_2c', via: %i[get post]
  match 'assessments/:assessment_id/verification-kbv-3', to: 'verification_questions#verification_kbv_3', via: %i[get post]
  get 'assessments/:assessment_id/verification-result', to: 'verification_questions#verification_result_get'
  post 'assessments/:assessment_id/verification-result', to: 'verification_questions#verification_result_post'

  post 'assessments/:assessment_id/evidence/:evidence_id/remove', to: 'assessments#remove_evidence_post'
end
