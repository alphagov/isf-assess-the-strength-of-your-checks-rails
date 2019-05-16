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

    get_assessment()['confidence_level_required'] = params[:confidence_level_required]

    redirect_to controller: 'assessments', action: 'overview'
  end

  def choose_evidence_get
    render "assessments/choose-evidence"
  end

  def choose_evidence_post
    if (not params[:evidence_type]) && (params[:evidence_type_other].blank?)
      @errors[:evidence_type] = 'You must choose a piece of evidence'
      render "assessments/choose-evidence" and return
    end
    if params[:id] == "new"
      id = SecureRandom.uuid
    else
      id = params[:id]
    end
    if params[:choose_evidence] == "other"
      params[:evidence_type] = nil
    else
      params[:evidence_type_other] = nil
    end
    get_evidence(id)['evidence_type'] = params[:evidence_type]
    get_evidence(id)['evidence_type_other'] = params[:evidence_type_other]
    redirect_to controller: 'assessments', action: 'overview'
  end

  private

  def get_evidence(id)
    return ((get_assessment()['evidence'] ||= Hash.new)[id] ||= Hash.new)
  end

end
