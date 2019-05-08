class AssessmentsController < ApplicationController
  def create
    redirect_to controller: 'assessment_questions', action: 'your_risk_get'
  end

end
