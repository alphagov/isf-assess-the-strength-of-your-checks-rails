require 'design_system/form'

class AssessmentsController < ApplicationController
  def create
    @assessment = Assessment.new
    @assessment.save
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

  def find_assessment(id = nil)
    Assessment.find(id || params[:assessment_id])
  end

  def find_evidence(id = nil)
    assessment = find_assessment
    assessment.evidence.find(id || params[:evidence_id])
  end

  def find_evidence_for_assessment(assessment)
    assessment.evidence
  end

  def save(form_responses)
    form_responses.save
  end
end
