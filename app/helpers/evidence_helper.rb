module EvidenceHelper
  def evidence_short_name(form, evidence)
    if evidence.evidence_type
      item = form.lists['evidence_type'].items[evidence.evidence_type]
      item.short_name || item.text
    else
      evidence.evidence_type_other
    end
  end
end