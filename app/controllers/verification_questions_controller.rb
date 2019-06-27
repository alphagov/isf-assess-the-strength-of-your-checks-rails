require 'design_system/form'
class VerificationQuestionsController < AssessmentsController
  def verification_start
    if request.post? && !params[:check_person_is_who_they_claim_to_be]
      @errors[:check_person_is_who_they_claim_to_be] = 'You must answer the question'
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-start"
      return
    end

    if params[:check_person_is_who_they_claim_to_be] == 'no'
      redirect_to action: 'verification_result_get'
    else
      redirect_to action: 'verification_1'
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:check_person_is_who_they_claim_to_be)
    save(assessment)
  end

  def verification_1
    if request.post?
      if !params[:check_person_is_the_same_person_the_evidence_was_issued_to]
        @errors[:check_person_is_the_same_person_the_evidence_was_issued_to] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-1"
      return
    end

    assessment = find_assessment
    assessment.check_person_is_the_same_person_the_evidence_was_issued_to = checkboxes_params_to_list(params[:check_person_is_the_same_person_the_evidence_was_issued_to])
    save(assessment)

    redirect_to action: :verification_physical_1
  end

  def verification_physical_1
    assessment = find_assessment
    if !assessment.check_person_is_the_same_person_the_evidence_was_issued_to.include? "physically_match"
      return redirect_to action: :verification_biometric_1
    end

    if request.post?
      if !params[:physically_matches_evidence]
        @errors[:physically_matches_evidence] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-physical-1"
      return
    end

    assessment.attributes = params.permit(:physically_matches_evidence)
    save(assessment)

    if assessment.physically_matches_evidence == 'no'
      redirect_to action: 'verification_physical_3a'
    else
      redirect_to action: 'verification_physical_2a'
    end
  end

  def verification_physical_2a
    if request.post?
      if !params[:detect_imposters]
        @errors[:detect_imposters] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-physical-2a"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:detect_imposters)
    save(assessment)

    if assessment.detect_imposters == 'no_training'
      redirect_to action: 'verification_physical_3a'
    else
      redirect_to action: 'verification_physical_2b'
    end
  end

  def verification_physical_2b
    if request.post?
      if !params[:refresh_training]
        @errors[:refresh_training] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      @shared = Form.new('shared')
      render "assessments/verification/verification-physical-2b"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:refresh_training)
    save(assessment)

    if assessment.refresh_training == 'none'
      redirect_to action: 'verification_physical_3a'
    else
      redirect_to action: 'verification_physical_2c'
    end
  end

  def verification_physical_2c
    if request.post?
      if !params[:how_do_you_check_properly]
        @errors[:how_do_you_check_properly] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-physical-2c"
      return
    end

    assessment = find_assessment
    assessment.how_do_you_check_properly = checkboxes_params_to_list(params[:how_do_you_check_properly])
    save(assessment)

    redirect_to action: 'verification_physical_3a'
  end

  def verification_physical_3a
    if request.post?
      if !params[:verification_system]
        @errors[:verification_system] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-physical-3a"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:verification_system)
    save(assessment)

    if assessment.verification_system == 'no'
      redirect_to action: 'verification_biometric_1'
    else
      redirect_to action: 'verification_physical_3b'
    end
  end

  def verification_physical_3b
    if request.post?
      if !params[:system_checks]
        @errors[:system_checks] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-physical-3b"
      return
    end

    assessment = find_assessment
    assessment.system_checks = checkboxes_params_to_list(params[:system_checks])
    save(assessment)

    redirect_to action: 'verification_physical_3c'
  end

  def verification_physical_3c
    if request.post?
      if !params[:properly_see_person]
        @errors[:properly_see_person] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-physical-3c"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:properly_see_person)
    save(assessment)

    redirect_to action: 'verification_biometric_1'
  end

  def verification_biometric_1
    assessment = find_assessment
    if !assessment.check_person_is_the_same_person_the_evidence_was_issued_to.include? "biometric_match"
      return redirect_to action: :verification_kbv_1
    end

    if request.post?
      if !params[:biometric_system_checks]
        @errors[:biometric_system_checks] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-biometric-1"
      return
    end

    assessment.biometric_system_checks = checkboxes_params_to_list(params[:biometric_system_checks])
    save(assessment)

    redirect_to action: 'verification_biometric_2'
  end

  def verification_biometric_2
    if request.post?
      if !params[:biometric_check_person_is_real]
        @errors[:biometric_check_person_is_real] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-biometric-2"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:biometric_check_person_is_real)
    save(assessment)

    redirect_to action: 'verification_biometric_3'
  end

  def verification_biometric_3
    if request.post?
      if !params[:protect_against_spoofing]
        @errors[:protect_against_spoofing] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-biometric-3"
      return
    end

    assessment = find_assessment
    assessment.protect_against_spoofing = checkboxes_params_to_list(params[:protect_against_spoofing])
    save(assessment)

    redirect_to action: 'verification_biometric_4'
  end

  def verification_biometric_4
    if request.post?
      if !params[:biometric_false_handled]
        @errors[:biometric_false_handled] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-biometric-4"
      return
    end

    assessment = find_assessment
    assessment.biometric_false_handled = checkboxes_params_to_list(params[:biometric_false_handled])
    save(assessment)

    redirect_to action: 'verification_biometric_5'
  end

  def verification_biometric_5
    if request.post?
      if !params[:biometric_captured_under_controlled_conditions]
        @errors[:biometric_captured_under_controlled_conditions] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-biometric-5"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:biometric_captured_under_controlled_conditions)
    save(assessment)

    redirect_to action: 'verification_kbv_1'
  end

  def verification_kbv_1
    assessment = find_assessment
    if !assessment.check_person_is_the_same_person_the_evidence_was_issued_to.include? "kbv_challenge"
      return redirect_to action: :verification_result_get
    end

    if request.post?
      if !params[:kbv_static_or_dynamic]
        @errors[:kbv_static_or_dynamic] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-kbv-1"
      return
    end

    assessment.attributes = params.permit(:kbv_static_or_dynamic)
    save(assessment)

    redirect_to action: 'verification_kbv_2a'
  end

  def verification_kbv_2a
    if request.post?
      if !params[:low_quality_kbv_challenges]
        @errors[:low_quality_kbv_challenges] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-kbv-2a"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:low_quality_kbv_challenges)
    save(assessment)

    if assessment.low_quality_kbv_challenges == 'no'
      redirect_to action: 'verification_result_get'
    else
      redirect_to action: 'verification_kbv_2b'
    end
  end

  def verification_kbv_2b
    if request.post?
      if !params[:medium_quality_kbv_challenges]
        @errors[:medium_quality_kbv_challenges] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-kbv-2b"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:medium_quality_kbv_challenges)
    save(assessment)

    if assessment.medium_quality_kbv_challenges == 'no'
      redirect_to action: 'verification_kbv_3'
    else
      redirect_to action: 'verification_kbv_2c'
    end
  end

  def verification_kbv_2c
    if request.post?
      if !params[:high_quality_kbv_challenges]
        @errors[:high_quality_kbv_challenges] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-kbv-2c"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:high_quality_kbv_challenges)
    save(assessment)

    redirect_to action: 'verification_kbv_3'
  end

  def verification_kbv_3
    if request.post?
      if !params[:kbv_multiple_or_single]
        @errors[:kbv_multiple_or_single] = 'You must answer the question'
      elsif (params[:kbv_multiple_or_single] == 'multiple') && !params[:kbv_how_many_checks_multiple]
        @errors[:kbv_how_many_checks_multiple] = 'You must answer the question'
      elsif (params[:kbv_multiple_or_single] == 'single') && !params[:kbv_how_many_checks_single]
        @errors[:kbv_how_many_checks_single] = 'You must answer the question'
      end
    end

    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-kbv-3"
      return
    end

    assessment = find_assessment
    assessment.attributes = params.permit(:kbv_multiple_or_single, :kbv_how_many_checks_multiple, :kbv_how_many_checks_single)
    save(assessment)

    redirect_to action: 'verification_result_get'
  end

  def verification_result_get
    render "assessments/verification/verification-result"
  end

  def verification_result_post
    @assessment = find_assessment
    @assessment.verification_section_is_complete = true
    @assessment.save
    redirect_to controller: :assessments, action: :overview
  end
end
