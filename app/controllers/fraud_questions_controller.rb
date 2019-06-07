require 'set'

require 'design_system/form'

class FraudQuestionsController < AssessmentsController
  def fraud_start
    if request.post? && !params[:identity_been_stolen_or_used_fraudulently]
      @errors[:identity_been_stolen_or_used_fraudulently] = 'You must answer the question'
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/fraud/fraud-start"
      return
    end

    if params[:identity_been_stolen_or_used_fraudulently] == 'no'
      redirect_to action: 'fraud_result_get'
    else
      redirect_to action: 'fraud_1'
    end

    assessment = find_assessment
    assessment.identity_been_stolen_or_used_fraudulently = params[:identity_been_stolen_or_used_fraudulently]
    save(assessment)
  end

  def fraud_1
    if request.post?
      if !params[:check_identity_not_stolen_or_used_fraudulently]
        @errors[:check_identity_not_stolen_or_used_fraudulently] = 'You must answer the question'
      end
    end

    @form = Form.new('assessments')
    if request.get? || !@errors.empty?
      render "assessments/fraud/fraud-1"
      return
    end

    params[:check_identity_not_stolen_or_used_fraudulently].each do |item|
      if item == "none"
        params[:check_identity_not_stolen_or_used_fraudulently] = []
      end
    end

    assessment = find_assessment
    assessment.check_identity_not_stolen_or_used_fraudulently = checkboxes_params_to_list(params[:check_identity_not_stolen_or_used_fraudulently])
    save(assessment)

    all_options_selected = Set.new(assessment.check_identity_not_stolen_or_used_fraudulently) == Set.new(@form.lists['check_identity_not_stolen_or_used_fraudulently'].items.keys) - Set['none']
    if all_options_selected
      redirect_to action: 'fraud_2'
    else
      redirect_to action: 'fraud_result_get'
    end
  end

  def fraud_2
    if request.post?
      if !params[:counter_fraud_data_sources]
        @errors[:counter_fraud_data_sources] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/fraud/fraud-2"
      return
    end

    assessment = find_assessment
    assessment.counter_fraud_data_sources = params[:counter_fraud_data_sources]
    save(assessment)


    if params[:counter_fraud_data_sources] == 'one'
      redirect_to action: 'fraud_result_get'
    else
      redirect_to action: 'fraud_3'
    end
  end

  def fraud_3
    if request.post?
      if !params[:idependent_counter_fraud_sources]
        @errors[:idependent_counter_fraud_sources] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/fraud/fraud-3"
      return
    end

    assessment = find_assessment
    assessment.idependent_counter_fraud_sources = params[:idependent_counter_fraud_sources]
    save(assessment)

    redirect_to action: 'fraud_result_get'
  end

  def fraud_result_get
    render "assessments/fraud/fraud-result"
  end
end
