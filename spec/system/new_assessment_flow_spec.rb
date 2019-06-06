require "rails_helper"
require_relative "steps_helper"

RSpec.feature 'New assessment flow', type: :system do
  scenario 'Create a new assessment' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    then_i_see_the_overview_screen
  end

  scenario 'Forget to choose a confidence level' do
    when_i_start_a_new_assessment
    click_button 'Continue'
    then_i_am_told_to_choose_a_confidence_level
  end
end
