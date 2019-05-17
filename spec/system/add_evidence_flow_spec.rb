require "rails_helper"
require_relative "new_assessment_flow_spec"

RSpec.feature 'Add evidence flow', type: :system do
  scenario 'Add new evidence to an assessment' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_evidence('Passport or travel document', 'UK passport')
    then_i_can_see_that_evidence_in_the_overview('passport_uk') # TODO eventually 'UK passport'
    and_i_add_a_new_piece_of_evidence('Certificate', 'Marriage certificate')
    then_i_can_see_that_evidence_in_the_overview('certificate_marriage') # TODO eventually 'Marriage certificate'
  end

  scenario 'Add other evidence to an assessment' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_other_evidence('Something else')
    then_i_can_see_that_evidence_in_the_overview('Something else')
  end

  scenario 'Add other evidence to an assessment after changing options' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_switch_between_evidence_type_to_other('Passport or travel document', 'UK passport', 'Something else')
    then_i_can_see_that_evidence_in_the_overview('Something else')
  end

  scenario 'Add regular evidence to an assessment after filling out other' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_switch_between_evidence_type_to_regular('Something else', 'Passport or travel document', 'UK passport')
    then_i_can_see_that_evidence_in_the_overview('passport_uk')
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

def then_i_can_see_that_evidence_in_the_overview(evidence_type)
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
