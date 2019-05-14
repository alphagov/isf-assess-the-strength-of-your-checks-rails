Rails.application.routes.draw do
  root 'home#index'

  get 'assessments/new', to: 'assessments#new'
  post 'assessments', to: 'assessments#create'

  get 'assessments/overview', to: 'assessments#overview'

  get 'assessments/your-risk', to: 'assessment_questions#your_risk_get'
  post 'assessments/your-risk', to: 'assessment_questions#your_risk_post'

end
