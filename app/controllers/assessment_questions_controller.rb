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

    (session['current_assessment'] ||= Hash.new)[:confidence_level_required] = params[:confidence_level_required]

    redirect_to controller: 'assessments', action: 'overview'
  end

  def choose_evidence_get
    render "assessments/choose-evidence"
  end

  def choose_evidence_post
    if not params[:choose_evidence]
      @errors[:choose_evidence] = 'You must choose a piece of evidence'
      render("assessments/choose-evidence") && return
    end
    id = if params[:id] == "new"
           SecureRandom.uuid
         else
           params[:id]
         end
    (((session['current_assessment'] ||= Hash.new)[:evidence] ||= Hash.new)[id] ||= Hash.new)[:choose_evidence] = params[:choose_evidence]
    (((session['current_assessment'] ||= Hash.new)[:evidence] ||= Hash.new)[id] ||= Hash.new)[:choose_evidence_other_name] = params[:choose_evidence_other_name]
    redirect_to controller: 'assessments', action: 'overview'
  end
end
