module EvidenceStepsHelper
  def and_i_add_a_new_piece_of_evidence(evidence_group, evidence_type)
    @evidence_text = evidence_type
    click_link 'Add evidence'
    choose evidence_group
    choose evidence_type
    click_button 'Continue'
  end

  def and_i_answer(question_snippet, answer)
    expect(page).to have_content question_snippet
    choose answer
    click_button 'Continue'
  end

  def and_i_answer_no_to_every_question
    ['physical features', 'cryptographic security', 'authoritative source', 'cancelled'].each do |question_snippet|
      and_i_answer question_snippet, 'No'
    end
  end

  def and_i_answer_physical_check_questions_positively
    ['physical features', 'original', 'errors', 'document capture app', 'recognised guidance', 'taught how to tell'].each do |question_snippet|
      and_i_answer question_snippet, 'Yes'
    end

    expect(page).to have_content 'refresh their training'
    choose 'Every year'
    click_button 'Continue'

    expect(page).to have_content 'official templates'
    choose 'Yes'
    click_button 'Continue'

    expect(page).to have_content 'templates updated'
    choose 'Every year'
    click_button 'Continue'

    ['expired', 'intercepted', 'visible security features', 'protects them from being tampered with'].each do |question_snippet|
      and_i_answer question_snippet, 'Yes'
    end

    expect(page).to have_content 'security features'
    check 'Designs printed using intaglio (raised) ink'
    check 'Designs that have been laser etched'
    check 'Watermarks'
    check 'Security fibres'
    check "Secondary background ('ghost') images"
    click_button 'Continue'

    and_i_answer 'consistent throughout', 'Yes'

    expect(page).to have_content 'equipment'
    check 'magnification tool'
    check 'low angle'
    check 'Another piece of equipment'
    check 'A non-specialist light source'
    click_button 'Continue'

    ['controlled', 'supervised', 'ultraviolet (UV) or infrared (IR)'].each do |question_snippet|
      and_i_answer question_snippet, 'Yes'
    end

    expect(page).to have_content 'UV or IR security features'
    check 'The paper the document is printed on'
    check 'The layout and design of the document'
    check 'Any fluorescent features'
    click_button 'Continue'
  end

  def and_i_answer_cryptographic_check_questions_positively
    and_i_answer 'cryptographic security', 'Yes'

    expect(page).to have_content 'cryptographic security features'
    check 'Check the evidence has not expired'
    check 'Check the digital signature is correct'
    check 'Check the signing key belongs to the organisation that issued the evidence'
    check 'Check the signing key is correct for that type of evidence'
    check 'Check the signing key has not been revoked'
    click_button 'Continue'
  end

  def and_i_answer_all_questions_positively
    and_i_answer_physical_check_questions_positively
    and_i_answer_cryptographic_check_questions_positively
    and_i_answer 'authoritative source', 'Yes'
    and_i_answer 'cancelled', 'Yes'
  end

  def and_i_answer_all_questions_except_cryptographic_positively
    and_i_answer_physical_check_questions_positively
    and_i_answer 'cryptographic security', 'No'
    and_i_answer 'authoritative source', 'Yes'
    and_i_answer 'cancelled', 'Yes'
  end

  def and_i_can_see_that_evidence_in_the_overview(evidence_type)
    then_i_see_the_overview_screen
    expect(page).to have_content evidence_type
  end

  def then_i_cannot_see_that_evidence_in_the_overview(evidence_type)
    then_i_see_the_overview_screen
    expect(page).not_to have_content evidence_type
  end
end
