class AssessmentsController < ApplicationController
  def create
    session[:current_assessment] = Hash.new
    redirect_to controller: 'assessment_questions', action: 'your_risk_get'
  end

  def overview
    render 'assessments/overview'
  end
end
