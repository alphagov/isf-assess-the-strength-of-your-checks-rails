require "rails_helper"
require_relative "steps_helper"
require_relative "evidence_steps_helper"

RSpec.feature 'Add evidence flow', type: :system do
  scenario 'Add new evidence to an assessment (short version)' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_evidence('Passport or travel document', 'UK passport')
    and_i_answer_no_to_every_question
    then_i_get_a_score('4', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('UK passport')
    and_i_add_a_new_piece_of_evidence('Certificate', 'Marriage or civil partnership certificate')
    and_i_answer_no_to_every_question
    then_i_get_a_score('2', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('Marriage or civil partnership certificate')
  end

  scenario 'Add other evidence to an assessment' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_other_evidence('Something else')
    and_i_say_the_evidence_strength_is('3')
    and_i_answer_no_to_every_question
    then_i_get_a_score('3', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('Something else')
  end

  scenario 'Add other evidence to an assessment after changing options' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_switch_between_evidence_type_to_other('Passport or travel document', 'UK passport', 'Something else')
    and_i_say_the_evidence_strength_is('3')
    and_i_answer_no_to_every_question
    then_i_get_a_score('3', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('Something else')
  end

  scenario 'Add regular evidence to an assessment after filling out other' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_switch_between_evidence_type_to_regular('Something else', 'Passport or travel document', 'UK passport')
    and_i_answer_no_to_every_question
    then_i_get_a_score('4', 'out of 4')
    and_i_can_see_that_evidence_in_the_overview('UK passport')
  end

  scenario 'Add new evidence to an assessment (long version – yes to all questions)' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_evidence('Passport or travel document', 'UK passport')
    and_i_answer_yes_to_every_question
    then_i_get_a_score('4', 'out of 4')
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

  def and_i_add_a_new_piece_of_other_evidence(evidence_other_name)
    @evidence_text = evidence_other_name
    click_link 'Add evidence'
    choose 'Other'
    fill_in 'evidence_type_other', with: evidence_other_name
    click_button 'Continue'
  end

  def and_i_say_the_evidence_strength_is(strength)
    expect(page).to have_content 'strength of this evidence'
    choose strength.to_s
    click_button 'Continue'
  end

  def then_i_get_a_score_for_that_evidence(strength, strength_additional_text)
    expect(page).to have_content "strength score of #{strength} #{strength_additional_text}"
    click_button 'Continue'
    find('th', text: @evidence_text).find(:xpath, "../../../tbody/tr[1]/td[2]").to have_content strength.to_s
    # expect(find('???')).to have_content 'Change' # TODO
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
end
