require 'design_system/form'
class AssessmentQuestionsController < AssessmentsController
  def your_risk
    # TODO more validation – perhaps once this is driven via YAML?
    if request.post? && !params[:confidence_level_required]
      @errors[:confidence_level_required] = 'You must choose a confidence level'
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/your-risk"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:confidence_level_required)
    save(assessment)

    if params[:confidence_level_required] == "none"
      redirect_to controller: 'assessment_questions', action: 'no_risk'
    else
      redirect_to controller: 'assessments', action: 'overview'
    end
  end

  def no_risk
    render "assessments/no-risk"
  end
end
