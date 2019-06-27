require 'design_system/form'
require 'securerandom'

class AssessmentsController < ApplicationController
  def create
    @assessment = Assessment.create
    AssessmentSessionAccess.create(assessment: @assessment, session_id: get_session_id)
    #reap_old_assessments
    redirect_to controller: 'assessment_questions', action: 'your_risk', assessment_id: @assessment.id
  end

  def overview
    @evidence_form = Form.new('evidence')
    @assessment = find_assessment
    @evidence_list = find_evidence_for_assessment(@assessment)
    @remove_evidence = if params[:remove_evidence_id].present?
                         find_evidence(params[:remove_evidence_id])
                       end
    render 'assessments/overview'
  end

  def remove_evidence_post
    if params[:confirmation].present?
      evidence = find_evidence
      evidence.destroy
    end
    redirect_to action: 'overview'
  end

private

  def get_session_id
    session['identifier'] ||= SecureRandom.uuid # not using session.id as it doesn't work in test :/
  end

  def find_assessment(id = nil)
    assessment = Assessment.find(id || params[:assessment_id])
    check_access assessment
    assessment
  end

  def check_access(assessment)
    AssessmentSessionAccess.find_by! assessment: assessment, session_id: get_session_id
    # will throw a 404 if no access found, which is perfect
  end

  def find_evidence(id = nil)
    assessment = find_assessment
    assessment.evidence.find(id || params[:evidence_id])
  end

  def find_evidence_for_assessment(assessment)
    # no access control here, we assume you used `find_assessment` to safely retrieve `assessment`
    assessment.evidence.where(is_complete: true)
  end

  def save(form_responses)
    form_responses.save
  end
end
