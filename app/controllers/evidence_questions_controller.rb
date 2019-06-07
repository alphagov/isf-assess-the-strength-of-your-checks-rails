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

    redirect_to controller: 'assessments', action: 'overview'
  end
end
