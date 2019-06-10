Rails.application.routes.draw do
  root 'home#index'

  get 'assessments/new', to: 'assessments#new'
  post 'assessments', to: 'assessments#create'

  get 'assessments/:assessment_id/overview', to: 'assessments#overview'

  match 'assessments/:assessment_id/your-risk', to: 'assessment_questions#your_risk', via: %i[get post]
  get 'assessments/:assessment_id/no-risk', to: 'assessment_questions#no_risk'

  match 'assessments/:assessment_id/evidence/:evidence_id/choose-evidence', to: 'evidence_questions#choose_evidence', via: %i[get post]

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
  match 'assessments/:assessment_id/verification-result', to: 'verification_questions#verification_result', via: %i[get post]
  match 'assessments/:assessment_id/verification-1', to: 'verification_questions#verification_1', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-1', to: 'verification_questions#verification_physical_1', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-2a', to: 'verification_questions#verification_physical_2a', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-2b', to: 'verification_questions#verification_physical_2b', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-2c', to: 'verification_questions#verification_physical_2c', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-3a', to: 'verification_questions#verification_physical_3a', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-3b', to: 'verification_questions#verification_physical_3b', via: %i[get post]
  match 'assessments/:assessment_id/verification-physical-3c', to: 'verification_questions#verification_physical_3c', via: %i[get post]

  post 'assessments/:assessment_id/evidence/:evidence_id/remove', to: 'assessments#remove_evidence_post'
end
