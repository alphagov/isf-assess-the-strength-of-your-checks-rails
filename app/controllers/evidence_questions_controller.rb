require 'design_system/form'
class EvidenceQuestionsController < AssessmentsController
  def choose_evidence
    if request.post? && !params[:evidence_type] && params[:evidence_type_other].blank?
      @errors[:evidence_type] = 'You must choose a piece of evidence'
    end

    if request.get? || !@errors.empty?
      @form = Form.new('evidence')
      render "assessments/evidence/choose-evidence"
      return
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

    evidence.attributes = params.permit(:evidence_type, :evidence_type_other)
    save(evidence)

    redirect_to action: :physical_0, evidence_id: evidence.id
  end

  def physical_0
    @evidence = find_evidence

    if request.post? && !params[:physical_check]
      @errors[:physical_check] = 'You must answer the question'
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      @form = Form.new('evidence')
      render "assessments/evidence/physical-0"
      return
    end

    @evidence.attributes = params.permit(:physical_check)
    save(@evidence)

    if @evidence.physical_check == 'yes'
      redirect_to action: 'physical_1'
    else
      redirect_to action: 'crypto_0'
    end
  end

  def crypto_0
    @evidence = find_evidence

    if request.post? && !params[:crypto_check]
      @errors[:crypto_check] = 'You must answer the question'
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      @form = Form.new('evidence')
      render "assessments/evidence/crypto-0"
      return
    end

    @evidence.attributes = params.permit(:crypto_check)
    save(@evidence)

    if @evidence.crypto_check == 'yes'
      redirect_to action: 'crypto_1'
    else
      redirect_to action: 'issuance'
    end
  end

  def issuance
    @evidence = find_evidence

    if request.post? && !params[:authoritative_source_check]
      @errors[:authoritative_source_check] = 'You must answer the question'
    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      @form = Form.new('evidence')
      render "assessments/evidence/issuance"
      return
    end

    @evidence.attributes = params.permit(:authoritative_source_check)
    save(@evidence)

    redirect_to action: 'revocation'
  end

  def revocation
    @shared = Form.new('shared')
    @form = Form.new('evidence')
    @evidence = find_evidence

    if request.post? && !params[:cancellation_check]
      @errors[:cancellation_check] = 'You must answer the question'
    end

    if request.get? || !@errors.empty?
      render "assessments/evidence/revocation"
      return
    end

    @evidence.attributes = params.permit(:cancellation_check)
    save(@evidence)

    redirect_to action: :evidence_result_get
  end

  def evidence_result_get
    render 'assessments/evidence/result'
  end
end
