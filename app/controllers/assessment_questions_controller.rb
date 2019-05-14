class AssessmentQuestionsController < AssessmentsController
  def your_risk_get
    render "assessments/your-risk"
  end

  def your_risk_post
    # TODO more validation – perhaps once this is driven via YAML?
    if not params[:confidence_level_required]
      @errors[:confidence_level_required] = 'You must choose a confidence level'
      render "assessments/your-risk" and return

    end

    (session['current_assessment'] ||= Hash.new)[:confidence_level_required] = params[:confidence_level_required]

    redirect_to controller: 'assessments', action: 'overview'
  end

end
