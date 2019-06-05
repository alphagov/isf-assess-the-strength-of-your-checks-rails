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

    if params[:confidence_level_required] == "none"
      redirect_to controller: 'assessment_questions', action: 'no_risk_get'
    else
      redirect_to controller: 'assessments', action: 'overview'
    end
  end

  def no_risk_get
    render "assessments/no-risk"
  end

  def no_risk_post
    redirect_to controller: 'assessments', action: 'overview'
  end

  def activity_start_get
    @shared = Form.new('shared')
    render "assessments/activity-start"
  end

  def activity_start_post
    if not params[:identity_exists_over_time]
      @errors[:identity_exists_over_time] = 'You must answer the question'
      return activity_start_get
    end

    if params[:identity_exists_over_time] == 'no'
      redirect_to action: 'activity_result_get'
    else
      redirect_to action: 'activity_1'
    end

    assessment = find_assessment
    assessment['identity_exists_over_time'] = params[:identity_exists_over_time]
    save(assessment)
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
      render "assessments/activity-1"
      return
    end

    assessment = find_assessment
    assessment['identity_with_organisation_proved'] = params[:identity_with_organisation_proved]
    assessment['org_check_method'] = params[:org_check_method]
    save(assessment)

    if params[:identity_with_organisation_proved] == 'no'
      redirect_to action: 'activity_result_get'
    else
      redirect_to action: 'activity_2'
    end
  end

  def activity_2
    if request.post?
      if !params[:org_activity_found]
        @errors[:org_activity_found] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      @form = Form.new('assessments')
      render "assessments/activity-2"
      return
    end

    assessment = find_assessment
    assessment['org_activity_found'] = params[:org_activity_found]
    save(assessment)

    if params[:org_activity_found] == 'no'
      redirect_to action: 'activity_result_get'
    else
      redirect_to action: 'activity_3'
    end
  end

  def activity_3
    if request.post?
      if !params[:activity_time_period]
        @errors[:activity_time_period] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      @form = Form.new('assessments')
      render "assessments/activity-3"
      return
    end

    assessment = find_assessment
    assessment['activity_time_period'] = params[:activity_time_period]
    save(assessment)

    redirect_to action: 'activity_result_get'
  end

  def activity_result_get
    render "assessments/activity-result"
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
