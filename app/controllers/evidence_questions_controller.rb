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
        redirect_to action: 'physical_1a'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end

  def physical_1a
    handle_evidence "assessments/evidence/physical-1a", [:check_original] do
      redirect_to action: 'physical_1b'
    end
  end

  def physical_1b
    handle_evidence "assessments/evidence/physical-1b", [:check_errors] do
      redirect_to action: 'physical_2a'
    end
  end

  def physical_2a
    handle_evidence "assessments/evidence/physical-2a", [:digital_tool_used] do
      if @evidence.digital_tool_used == 'yes'
        redirect_to action: 'physical_2b'
      else
        redirect_to action: 'physical_3a'
      end
    end
  end

  def physical_2b
    handle_evidence "assessments/evidence/physical-2b", [:digital_tool_follows_standard] do
      if @evidence.digital_tool_follows_standard == 'yes'
        redirect_to action: 'physical_3a'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end

  def physical_3a
    handle_evidence "assessments/evidence/physical-3a", [:checker_trained] do
      if @evidence.checker_trained == 'yes'
        redirect_to action: 'physical_3b'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end

  def physical_3b
    handle_evidence "assessments/evidence/physical-3b", [:checker_training_frequency] do
      redirect_to action: 'physical_4a'
    end
  end

  def physical_4a
    handle_evidence "assessments/evidence/physical-4a", [:official_templates_used] do
      if @evidence.official_templates_used == 'yes'
        redirect_to action: 'physical_4b'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end

  def physical_4b
    handle_evidence "assessments/evidence/physical-4b", [:official_templates_update_frequency] do
      if @evidence.official_templates_update_frequency == 'none'
        redirect_to action: 'crypto_0'
      else
        redirect_to action: 'physical_5'
      end
    end
  end

  def physical_5
    handle_evidence "assessments/evidence/physical-5", [:expiry_check] do
      if @evidence.expiry_check == 'yes'
        redirect_to action: 'physical_6'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end


  def physical_6
    handle_evidence "assessments/evidence/physical-6", [:replay_attack_check] do
      if @evidence.replay_attack_check == 'yes'
        redirect_to action: 'physical_7'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end

  def physical_7
    handle_evidence "assessments/evidence/physical-7", [:security_features_check] do
      redirect_to action: 'physical_8'
    end
  end

  def physical_8
    handle_evidence "assessments/evidence/physical-8", [:security_features] do
      if @evidence.security_features.include? 'visible'
        redirect_to action: 'visible_1'
      elsif @evidence.security_features.include? 'uv_ir'
        redirect_to action: 'uv_ir_1'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end

  def visible_1
    handle_evidence "assessments/evidence/visible-1", [:tamper_protected] do
      if @evidence.tamper_protected == 'yes'
        redirect_to action: 'visible_2'
      elsif @evidence.security_features.include? 'uv_ir'
        redirect_to action: 'uv_ir_1'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end

  def visible_2
    handle_evidence "assessments/evidence/visible-2", [:visible_features] do
      redirect_to action: 'visible_3'
    end
  end

  def visible_3
    handle_evidence "assessments/evidence/visible-3", [:visible_features_consistency] do
      redirect_to action: 'visible_4'
    end
  end

  def visible_4
    handle_evidence "assessments/evidence/visible-4", [:visible_features_equipment] do
      redirect_to action: 'visible_5'
    end
  end

  def visible_5
    handle_evidence "assessments/evidence/visible-5", [:visible_features_controlled_conditions] do
      redirect_to action: 'visible_6'
    end
  end

  def visible_6
    handle_evidence "assessments/evidence/visible-6", [:visible_features_supervision] do
      if @evidence.security_features.include? 'uv_ir'
        redirect_to action: 'uv_ir_1'
      else
        redirect_to action: 'crypto_0'
      end
    end
  end

  def uv_ir_1
    handle_evidence "assessments/evidence/uv-ir-1", [:uv_ir_features] do
      redirect_to action: 'uv_ir_2'
    end
  end

  def uv_ir_1
    handle_evidence "assessments/evidence/uv-ir-1", [:uv_ir_tamper_check] do
      redirect_to action: 'crypto_0'
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

  def crypto_1
    handle_evidence "assessments/evidence/crypto-0", [:crypto_features] do
      redirect_to action: 'issuance'
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
    @form = Form.new('evidence')
    @evidence = find_evidence
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
      render view
      return
    end

    @evidence.attributes = params.permit(required_params)
    save(@evidence)
    yield
  end
end
