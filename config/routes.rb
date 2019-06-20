Rails.application.routes.draw do
  root 'home#index'

  get 'assessments/new', to: 'assessments#new'
  post 'assessments', to: 'assessments#create'

  get 'assessments/:assessment_id/overview', to: 'assessments#overview'

  match 'assessments/:assessment_id/your-risk', to: 'assessment_questions#your_risk', via: %i[get post]
  get 'assessments/:assessment_id/no-risk', to: 'assessment_questions#no_risk'

  match 'assessments/:assessment_id/evidence/:evidence_id/choose-evidence', to: 'evidence_questions#choose_evidence', via: %i[get post]

  match 'assessments/:assessment_id/evidence/:evidence_id/physical-0', to: 'evidence_questions#physical_0', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-1a', to: 'evidence_questions#physical_1a', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-1b', to: 'evidence_questions#physical_1b', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-2a', to: 'evidence_questions#physical_2a', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-2b', to: 'evidence_questions#physical_2b', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-3a', to: 'evidence_questions#physical_3a', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-3b', to: 'evidence_questions#physical_3b', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-4a', to: 'evidence_questions#physical_4a', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-4b', to: 'evidence_questions#physical_4b', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-5', to: 'evidence_questions#physical_5', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/physical-6', to: 'evidence_questions#physical_6', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/visible-0', to: 'evidence_questions#visible_0', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/visible-1', to: 'evidence_questions#visible_1', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/visible-2', to: 'evidence_questions#visible_2', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/visible-3', to: 'evidence_questions#visible_3', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/visible-4', to: 'evidence_questions#visible_4', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/visible-5', to: 'evidence_questions#visible_5', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/visible-6', to: 'evidence_questions#visible_6', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/uv-ir-0', to: 'evidence_questions#uv_ir_0', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/uv-ir-1', to: 'evidence_questions#uv_ir_1', via: %i[get post]

  match 'assessments/:assessment_id/evidence/:evidence_id/crypto-0', to: 'evidence_questions#crypto_0', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/crypto-1', to: 'evidence_questions#crypto_1', via: %i[get post]

  match 'assessments/:assessment_id/evidence/:evidence_id/issuance', to: 'evidence_questions#issuance', via: %i[get post]
  match 'assessments/:assessment_id/evidence/:evidence_id/revocation', to: 'evidence_questions#revocation', via: %i[get post]

  get 'assessments/:assessment_id/evidence/:evidence_id/result', to: 'evidence_questions#evidence_result_get'

  match 'assessments/:assessment_id/activity-start', to: 'activity_questions#activity_start', via: %i[get post]
  get 'assessments/:assessment_id/activity-result', to: 'activity_questions#activity_result_get'
  match 'assessments/:assessment_id/activity-1', to: 'activity_questions#activity_1', via: %i[get post]
  match 'assessments/:assessment_id/activity-2', to: 'activity_questions#activity_2', via: %i[get post]
  match 'assessments/:assessment_id/activity-3', to: 'activity_questions#activity_3', via: %i[get post]

  match 'assessments/:assessment_id/fraud-start', to: 'fraud_questions#fraud_start', via: %i[get post]
  get 'assessments/:assessment_id/fraud-result', to: 'fraud_questions#fraud_result_get'
  match 'assessments/:assessment_id/fraud-1', to: 'fraud_questions#fraud_1', via: %i[get post]
  match 'assessments/:assessment_id/fraud-2', to: 'fraud_questions#fraud_2', via: %i[get post]
  match 'assessments/:assessment_id/fraud-3', to: 'fraud_questions#fraud_3', via: %i[get post]

  match 'assessments/:assessment_id/verification-start', to: 'verification_questions#verification_start', via: %i[get post]
  match 'assessments/:assessment_id/verification-result', to: 'verification_questions#verification_result_get', via: %i[get post]
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

  post 'assessments/:assessment_id/evidence/:evidence_id/remove', to: 'assessments#remove_evidence_post'
end
