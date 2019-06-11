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
      if !assessment.evidence_id_list.delete(id).nil?
        save(assessment)
        delete(Evidence, id)
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
    find(Assessment, id || params[:assessment_id])
  end

  def find_evidence(id = nil)
    find(Evidence, id || params[:evidence_id])
  end

  def find_evidence_for_assessment(assessment)
    assessment.evidence_id_list.map { |evidence_id| find(Evidence, evidence_id) }.compact
  end

  def find(model_class, id)
    form_responses = session[:form_responses][model_class.name][id] || raise(FormResponsesNotFound)
    model_class.new(form_responses) if !form_responses.nil?
  end

  def save(form_responses)
    ((session[:form_responses] ||= Hash.new)[form_responses.class.name] ||= Hash.new)[form_responses.id] = form_responses.serializable_hash
  end

  def delete_assessment(assessment)
    assessment.evidence_id_list.each do |evidence_id|
      delete(Evidence, evidence_id)
    end
    delete(Assessment, assessment.id)
  end

  def delete(model_class, id)
    session[:form_responses][model_class.name].delete(id)
  end

  def all_assessments
    session[:form_responses][Assessment.name].each_value.map { |form_responses| Assessment.new(form_responses) }.compact
  end

  def reap_old_assessments
    assessments_sorted_by_date = all_assessments.sort_by(&:date_created)
    all_but_most_recent = assessments_sorted_by_date[0..-(Rails.configuration.number_of_assessments_to_keep + 1)]
    if !all_but_most_recent.nil?
      all_but_most_recent.each do |assessment|
        delete_assessment(assessment)
      end
    end
  end
end
