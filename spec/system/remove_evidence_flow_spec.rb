require "rails_helper"
require_relative "steps_helper"
require_relative "evidence_steps_helper"

RSpec.feature 'Remove evidence flow', type: :system do
  include EvidenceStepsHelper

  scenario 'Remove evidence from an assessment' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_add_a_new_piece_of_evidence('Passport or travel document', 'UK passport')
    and_i_answer_no_to_every_question
    and_i_continue_past_the_result_screen
    and_i_add_a_new_piece_of_evidence('Certificate', 'Marriage or civil partnership certificate')
    and_i_answer_no_to_every_question
    and_i_continue_past_the_result_screen
    and_i_remove_that_evidence('UK passport')
    then_i_cannot_see_that_evidence_in_the_overview('UK passport')
    and_i_can_see_that_evidence_in_the_overview('Marriage or civil partnership certificate')
  end

  def and_i_continue_past_the_result_screen
    click_button 'Continue'
  end

  def and_i_remove_that_evidence(evidence_type)
    container = page.find('.evidence', text: evidence_type)
    container.click_link 'Remove'
    click_button 'Yes, remove'
  end
end
