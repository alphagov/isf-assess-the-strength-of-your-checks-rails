require 'design_system/form'
class AssessmentQuestionsController < AssessmentsController
  def your_risk_get
    @form = Form.new('assessments')

    render "assessments/your-risk"
  end

  def your_risk_post
    # TODO more validation – perhaps once this is driven via YAML?
    if not params[:confidence_level_required]
      @errors[:confidence_level_required] = 'You must choose a confidence level'
      return your_risk_get

    end

    assessment = find_assessment
    assessment['confidence_level_required'] = params[:confidence_level_required]
    save(assessment)

    redirect_to controller: 'assessments', action: 'overview'
  end

  def choose_evidence_get
    @form = Form.new('evidence')
    render "assessments/choose-evidence"
  end

  def choose_evidence_post
    if (not params[:evidence_type]) && params[:evidence_type_other].blank?
      @errors[:evidence_type] = 'You must choose a piece of evidence'
      return choose_evidence_get
    end

    if params[:evidence_id] == "new"
      evidence = Evidence.new
      assessment = find_assessment
      assessment.add_evidence(evidence)
      save(assessment)
    else
      evidence = find_evidence
    end

    if params[:evidence_group] == "other"
      params[:evidence_type] = nil
    else
      params[:evidence_type_other] = nil
    end

    evidence['evidence_type'] = params[:evidence_type]
    evidence['evidence_type_other'] = params[:evidence_type_other]
    save(evidence)

    redirect_to controller: 'assessments', action: 'overview'
  end
end
