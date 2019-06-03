Rails.application.routes.draw do
  root 'home#index'

  get 'assessments/new', to: 'assessments#new'
  post 'assessments', to: 'assessments#create'

  get 'assessments/:assessment_id/overview', to: 'assessments#overview'

  get 'assessments/:assessment_id/your-risk', to: 'assessment_questions#your_risk_get'
  post 'assessments/:assessment_id/your-risk', to: 'assessment_questions#your_risk_post'

  get 'assessments/:assessment_id/no-risk', to: 'assessment_questions#no_risk_get'
  post 'assessments/:assessment_id/no-risk', to: 'assessment_questions#no_risk_post'

  get 'assessments/:assessment_id/evidence/:evidence_id/choose-evidence', to: 'assessment_questions#choose_evidence_get'
  post 'assessments/:assessment_id/evidence/:evidence_id/choose-evidence', to: 'assessment_questions#choose_evidence_post'

  post 'assessments/:assessment_id/evidence/:evidence_id/remove', to: 'assessments#remove_evidence_post'
end
