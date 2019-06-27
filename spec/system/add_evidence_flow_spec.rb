require "rails_helper"
require_relative "steps_helper"

RSpec.feature 'Add evidence flow', type: :system do
  scenario 'Add new evidence to an assessment (short version)' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_evidence('Passport or travel document', 'UK passport')
    and_i_answer_no_to_every_question
    then_i_get_a_score('XX', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('UK passport')
    and_i_add_a_new_piece_of_evidence('Certificate', 'Marriage or civil partnership certificate')
    and_i_answer_no_to_every_question
    then_i_get_a_score('XX', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('Marriage or civil partnership certificate')
  end

  scenario 'Add other evidence to an assessment' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_other_evidence('Something else')
    and_i_answer_no_to_every_question
    then_i_get_a_score('XX', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('Something else')
  end

  scenario 'Add other evidence to an assessment after changing options' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_switch_between_evidence_type_to_other('Passport or travel document', 'UK passport', 'Something else')
    and_i_answer_no_to_every_question
    then_i_get_a_score('XX', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('Something else')
  end

  scenario 'Add regular evidence to an assessment after filling out other' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_switch_between_evidence_type_to_regular('Something else', 'Passport or travel document', 'UK passport')
    and_i_answer_no_to_every_question
    then_i_get_a_score('XX', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('UK passport')
  end

  scenario 'Add new evidence to an assessment (long version – yes to all questions)' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_evidence('Passport or travel document', 'UK passport')
    and_i_answer_yes_to_every_question
    then_i_get_a_score('XX', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('UK passport')
  end

  scenario 'Add new evidence but without completing it' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_record_the_current_uri
    and_i_add_a_new_piece_of_evidence('Passport or travel document', 'UK passport')
    and_i_answer_no_to_every_question
    and_i_go_to_that_uri # skip submission on 'results' screen: evidence not marked 'complete'
    then_i_cannot_see_that_evidence_in_the_overview('UK passport')
  end
end

def and_i_add_a_new_piece_of_evidence(evidence_group, evidence_type)
  click_link 'Add evidence'
  choose evidence_group
  choose evidence_type
  click_button 'Continue'
end

def and_i_add_a_new_piece_of_other_evidence(evidence_other_name)
  click_link 'Add evidence'
  choose 'Other'
  fill_in 'evidence_type_other', with: evidence_other_name
  click_button 'Continue'
end

def and_i_answer_no_to_every_question
  ['physical features', 'cryptographic security', 'authoritative source', 'cancelled'].each do |question_snippet|
    expect(page).to have_content question_snippet
    choose 'No'
    click_button 'Continue'
  end
end

def and_i_answer_yes_to_every_question
  ['physical features', 'original', 'errors', 'document capture app', 'recognised guidance', 'taught how to tell'].each do |question_snippet|
    expect(page).to have_content question_snippet
    choose 'Yes'
    click_button 'Continue'
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
    expect(page).to have_content question_snippet
    choose 'Yes'
    click_button 'Continue'
  end

  expect(page).to have_content 'security features'
  check 'Designs printed using intaglio (raised) ink'
  check 'Designs that have been laser etched'
  check 'Watermarks'
  check 'Security fibres'
  check "Secondary background ('ghost') images"
  click_button 'Continue'

  expect(page).to have_content 'consistent throughout'
  choose 'Yes'
  click_button 'Continue'

  expect(page).to have_content 'equipment'
  check 'magnification tool'
  check 'low angle'
  check 'Another piece of equipment'
  check 'A non-specialist light source'
  click_button 'Continue'

  ['controlled', 'supervised', 'ultraviolet (UV) or infrared (IR)'].each do |question_snippet|
    expect(page).to have_content question_snippet
    choose 'Yes'
    click_button 'Continue'
  end

  expect(page).to have_content 'UV or IR security features'
  check 'The paper the document is printed on'
  check 'The layout and design of the document'
  check 'Any fluorescent features'
  click_button 'Continue'

  expect(page).to have_content 'cryptographic security'
  choose 'Yes'
  click_button 'Continue'

  expect(page).to have_content 'cryptographic security features'
  check 'Check the evidence has not expired'
  check 'Check the digital signature is correct'
  check 'Check the signing key belongs to the organisation that issued the evidence'
  check 'Check the signing key is correct for that type of evidence'
  check 'Check the signing key has not been revoked'
  click_button 'Continue'

  ['authoritative source', 'cancelled'].each do |question_snippet|
    expect(page).to have_content question_snippet
    choose 'Yes'
    click_button 'Continue'
  end
end

def then_i_get_a_score(score, additional_text)
  expect(page).to have_content "#{score} #{additional_text}"
  click_button 'Continue'
  # expect(find('??')).to have_text score # TODO
  # expect(find('???')).to have_content 'Change' # TODO
end

def and_i_can_see_that_evidence_in_the_overview(evidence_type)
  then_i_see_the_overview_screen
  expect(page).to have_content evidence_type
end

def then_i_cannot_see_that_evidence_in_the_overview(evidence_type)
  then_i_see_the_overview_screen
  expect(page).not_to have_content evidence_type
end

def and_i_switch_between_evidence_type_to_other(evidence_group, evidence_type, evidence_other_name)
  click_link 'Add evidence'
  choose evidence_group
  choose evidence_type
  choose 'Other'
  fill_in 'evidence_type_other', with: evidence_other_name
  click_button 'Continue'
end

def and_i_switch_between_evidence_type_to_regular(evidence_other_name, evidence_group, evidence_type)
  click_link 'Add evidence'
  choose 'Other'
  fill_in 'evidence_type_other', with: evidence_other_name
  choose evidence_group
  choose evidence_type
  click_button 'Continue'
end
