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
    assessment['check_person_is_who_they_claim_to_be'] = params[:check_person_is_who_they_claim_to_be]
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

    params[:check_person_is_the_same_person_the_evidence_was_issued_to].each do |item|
      if item == "dont_check"
        params[:check_person_is_the_same_person_the_evidence_was_issued_to] = []
      end
    end

    assessment = find_assessment
    assessment['check_person_is_the_same_person_the_evidence_was_issued_to'] = params[:check_person_is_the_same_person_the_evidence_was_issued_to]
    save(assessment)

    if params[:check_person_is_the_same_person_the_evidence_was_issued_to] == []
      redirect_to action: 'verification_result_get'
    else
      redirect_to action: '' #TODO: numerous ways to go
    end
  end

  def verification_physical_1
    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-physical-1"
      nil
    end
  end

  def verification_physical_2a
    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-physical-2a"
      nil
    end
  end

  def verification_physical_2b
    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-physical-2b"
      nil
    end
  end

  def verification_physical_2c
    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-physical-2c"
      nil
    end
  end

  def verification_physical_3a
    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      render "assessments/verification/verification-physical-3a"
      nil
    end
  end

  def verification_physical_3b
    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-physical-3b"
      nil
    end
  end

  def verification_physical_3c
    if request.get? || !@errors.empty?
      @form = Form.new('assessments')
      render "assessments/verification/verification-physical-3c"
      nil
    end
  end

  def verification_result_get
    render "assessments/verification/verification-result"
  end
end
