require "rails_helper"
require_relative "new_assessment_flow_spec"

RSpec.feature 'Add evidence flow', :type => :system do
  scenario 'Add new evidence to an assessment' do
    when_I_start_a_new_assessment
    and_I_choose_a_regular_confidence_level
    and_I_add_a_new_piece_of_evidence('Passport or travel document', 'UK passport')
    then_I_can_see_that_evidence_in_the_overview('passport_uk')  # TODO eventually 'UK passport'
    and_I_add_a_new_piece_of_evidence('Certificate', 'Marriage certificate')
    then_I_can_see_that_evidence_in_the_overview('certificate_marriage')  # TODO eventually 'Marriage certificate'
  end

end

def and_I_add_a_new_piece_of_evidence(evidence_group, evidence_type)
  click_link 'Add evidence'
  choose evidence_group
  choose evidence_type
  click_button 'Continue'
end

def then_I_can_see_that_evidence_in_the_overview(evidence_type)
  then_I_see_the_overview_screen
  expect(page).to have_content evidence_type
end
