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
    handle_evidence "assessments/evidence/physical-0", [:physical_check] do
      if @evidence.physical_check == 'yes'
        redirect_to action: 'physical_1'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end

  def crypto_0
    handle_evidence "assessments/evidence/crypto-0", [:crypto_check] do
      if @evidence.crypto_check == 'yes'
        redirect_to action: 'crypto_1'
      else
        redirect_to action: 'issuance'
      end
    end
  end

  def issuance
    handle_evidence "assessments/evidence/issuance", [:authoritative_source_check] do
      redirect_to action: 'revocation'
    end
  end

  def revocation
    handle_evidence "assessments/evidence/revocation", [:cancellation_check] do
      redirect_to action: :evidence_result_get
    end
  end

  def evidence_result_get
    render 'assessments/evidence/result'
  end

private

  def handle_evidence(view, required_params)
    @shared = Form.new('shared')
    @form = Form.new('evidence')
    @evidence = find_evidence

    if request.post?
      begin
        params.require(required_params)
      rescue ActionController::ParameterMissing => e
        @errors[e.param] = 'You must answer the question'
      end

    end

    if request.get? || !@errors.empty?
      @shared = Form.new('shared')
      @form = Form.new('evidence')
      render view
      return
    end

    @evidence.attributes = params.permit(required_params)
    save(@evidence)
    yield
  end
end
