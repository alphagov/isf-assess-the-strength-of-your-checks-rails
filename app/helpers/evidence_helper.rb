module EvidenceHelper
  def evidence_short_name(form, evidence)
    if evidence.evidence_type
      item = form.lists['evidence_type'].items[evidence.evidence_type]
      item.short_name || item.text
    else
      evidence.evidence_type_other
    end
  end

  def evidence_strength(form, evidence)
    if evidence.evidence_type
      item = form.lists['evidence_type'].items[evidence.evidence_type]
      item.strength
    else
      evidence.custom_strength
    end
  end
end
