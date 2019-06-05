class AssessmentsController < ApplicationController
  def create
    @assessment = Assessment.new
    save(@assessment)
    reap_old_assessments
    redirect_to controller: 'assessment_questions', action: 'your_risk', assessment_id: @assessment.id
  end

  def overview
    @assessment = find_assessment
    @evidence_list = find_evidence_for_assessment(@assessment)
    @remove_evidence = if params[:remove_evidence_id].present?
                         find_evidence(params[:remove_evidence_id])
                       end
    render 'assessments/overview'
  end

  def remove_evidence_post
    if params[:confirmation].present?
      id = params[:evidence_id]
      # note: evidence is created in AssessmentQuestionsController::choose_evidence_post
      assessment = find_assessment
      if !assessment['evidence'].delete(id).nil?
        save(assessment)
        delete(id)
      end
    end
    redirect_to action: 'overview'
  end

private

# These methods exist to marshall our models in and out of the session, unless and
# until we decide to store them in a database like normal people. (If we do that,
# we have to think about access control.)
  class FormResponsesNotFound < StandardError; end

  def find_assessment(id = nil)
    form_responses = find_form_responses(id || params[:assessment_id])
    Assessment.new(form_responses) if !form_responses.nil?
  end

  def find_evidence(id = nil)
    form_responses = find_form_responses(id || params[:evidence_id])
    Evidence.new(form_responses) if !form_responses.nil?
  end

  def find_evidence_for_assessment(assessment)
    assessment.evidence_id_list.map { |evidence_id| find_evidence(evidence_id) }.compact
  end

  def find_form_responses(id)
    session[:form_responses][id] || raise(FormResponsesNotFound)
  end

  def save(form_responses)
    (session[:form_responses] ||= Hash.new)[form_responses[:id]] = form_responses
  end

  def delete_assessment(assessment)
    assessment.evidence_id_list.each do |evidence_id|
      delete(evidence_id)
    end
    delete(assessment['id'])
  end

  def delete(id)
    session[:form_responses].delete(id)
  end

  def all_assessments
    session[:form_responses].each_value.select { |form_responses| form_responses['_type'] == 'assessment' }.map { |form_responses| Assessment.new(form_responses) }.compact
  end

  def reap_old_assessments
    assessments_sorted_by_date = all_assessments.sort_by { |assessment| assessment["date_created"] }
    all_but_most_recent = assessments_sorted_by_date[0..-(Rails.configuration.number_of_assessments_to_keep + 1)]
    if !all_but_most_recent.nil?
      all_but_most_recent.each do |assessment|
        delete_assessment(assessment)
      end
    end
  end
end
