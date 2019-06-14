require "rails_helper"
require_relative "steps_helper"

RSpec.feature 'Remove evidence flow', type: :system do
  scenario 'Remove evidence from an assessment' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_evidence('Passport or travel document', 'UK passport')
    and_i_answer_no_to_every_question
    then_i_get_a_score('XX', 'out of 4')
    and_i_add_a_new_piece_of_evidence('Certificate', 'Marriage certificate')
    and_i_answer_no_to_every_question
    then_i_get_a_score('XX', 'out of 4')
    then_i_remove_that_evidence('UK passport')
    then_i_cannot_see_that_evidence_in_the_overview('UK passport')
    and_i_can_see_that_evidence_in_the_overview('Marriage certificate')
  end
end

def then_i_remove_that_evidence(evidence_type)
  container = page.find('.evidence', text: evidence_type)
  container.click_link 'Remove'
  click_button 'Yes, remove'
end

def then_i_cannot_see_that_evidence_in_the_overview(evidence_type)
  then_i_see_the_overview_screen
  expect(page).not_to have_content evidence_type
end
