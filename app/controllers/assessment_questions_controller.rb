class AssessmentQuestionsController < AssessmentsController
  def your_risk_get
    render "assessments/your-risk"
  end

  def your_risk_post
    # TODO more validation – perhaps once this is driven via YAML?
    if not params[:confidence_level_required]
      @errors[:confidence_level_required] = 'You must choose a confidence level'
      render("assessments/your-risk") && return

    end

    assessment = find_assessment
    assessment['confidence_level_required'] = params[:confidence_level_required]
    save(assessment)

    redirect_to controller: 'assessments', action: 'overview'
  end

  def choose_evidence_get
    render "assessments/choose-evidence"
  end

  def choose_evidence_post
    if (not params[:evidence_type]) && params[:evidence_type_other].blank?
      @errors[:evidence_type] = 'You must choose a piece of evidence'
      render("assessments/choose-evidence") && return
    end

    if params[:evidence_id] == "new"
      evidence = Evidence.new
      assessment = find_assessment
      assessment.add_evidence(evidence)
      save(assessment)
    else
      evidence = find_evidence
    end

    if params[:choose_evidence] == "other"
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
