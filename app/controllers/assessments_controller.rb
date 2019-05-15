class AssessmentsController < ApplicationController
  def create
    session[:current_assessment] = Hash.new
    redirect_to controller: 'assessment_questions', action: 'your_risk_get'
  end

  def overview
    @assessment = get_assessment()
    render 'assessments/overview'
  end

  private

  def get_assessment
    return session['current_assessment'] ||= Hash.new
  end

end
