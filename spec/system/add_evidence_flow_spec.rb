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
