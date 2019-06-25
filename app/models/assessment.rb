class Assessment < ApplicationRecord
  has_many :evidence
  after_validation :empty_lists_where_required

private

  def empty_lists_where_required
    if self.check_identity_not_stolen_or_used_fraudulently&.include? 'none'
      self.check_identity_not_stolen_or_used_fraudulently = []
    end
    if self.identity_with_organisation_proved == 'no'
      self.org_check_method = []
    end
    if self.how_do_you_check_properly&.include? 'none'
      self.how_do_you_check_properly = []
    end
    if self.check_person_is_the_same_person_the_evidence_was_issued_to&.include? 'dont_check'
      self.check_person_is_the_same_person_the_evidence_was_issued_to = []
    end
    if self.biometric_false_handled&.include? 'does_not_handle'
      self.biometric_false_handled = []
    end
    if self.kbv_multiple_or_single == "multiple"
      self.kbv_how_many_checks_single = nil
    elsif self.kbv_multiple_or_single == "single"
      self.kbv_how_many_checks_multiple = nil
    end
  end
end
