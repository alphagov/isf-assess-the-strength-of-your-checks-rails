class AssessmentsController < ApplicationController
  def create
    @assessment = Assessment.new
    save(@assessment)
    redirect_to controller: 'assessment_questions', action: 'your_risk_get', assessment_id: @assessment.id
  end

  def overview
    @assessment = find_assessment
    @evidence_list = find_evidence_for_assessment(@assessment)
    render 'assessments/overview'
  end

private

# These methods exist to marshall our models in and out of the session, unless and
# until we decide to store them in a database like normal people. (If we do that,
# we have to think about access control.)

  def find_assessment
    Assessment.new(find_form_responses(params[:assessment_id]))
  end

  def find_evidence
    Evidence.new(find_form_responses(params[:evidence_id]))
  end

  def find_evidence_for_assessment(assessment)
    assessment.evidence_id_list.map { |evidence_id| Evidence.new(find_form_responses(evidence_id)) }
  end

  def find_form_responses(id)
    session[:form_responses][id]
  end

  def save(form_responses)
    (session[:form_responses] ||= Hash.new)[form_responses[:id]] = form_responses
  end
end
