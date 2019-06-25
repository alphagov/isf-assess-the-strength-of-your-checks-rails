require 'design_system/form'
class ActivityQuestionsController < AssessmentsController
  def activity_start
    if request.post? && !params[:identity_exists_over_time]
      @errors[:identity_exists_over_time] = 'You must answer the question'
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/activity/activity-start"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:identity_exists_over_time)
    save(assessment)

    if params[:identity_exists_over_time] == 'no'
      redirect_to action: 'activity_result_get'
    else
      redirect_to action: 'activity_1'
    end
  end

  def activity_1
    if request.post?
      if !params[:identity_with_organisation_proved]
        @errors[:identity_with_organisation_proved] = 'You must answer the question'
      elsif (params[:identity_with_organisation_proved] == 'yes') && !params[:org_check_method]
        @errors[:org_check_method] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      @form = Form.new('assessments')
      render "assessments/activity/activity-1"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:identity_with_organisation_proved)
    assessment.org_check_method = checkboxes_params_to_list(params[:org_check_method])
    save(assessment)

    if params[:identity_with_organisation_proved] == 'no'
      redirect_to action: 'activity_result_get'
    else
      redirect_to action: 'activity_2'
    end
  end

  def activity_2
    if request.post?
      if !params[:activity_time_period]
        @errors[:activity_time_period] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      @form = Form.new('assessments')
      render "assessments/activity/activity-2"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:activity_time_period)
    save(assessment)

    redirect_to action: 'activity_3'
  end

  def activity_3
    if request.post?
      if !params[:org_activity_found]
        @errors[:org_activity_found] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      @form = Form.new('assessments')
      render "assessments/activity/activity-3"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:org_activity_found)
    save(assessment)

    redirect_to action: 'activity_result_get'
  end

  def activity_result_get
    render "assessments/activity/activity-result"
  end
end
