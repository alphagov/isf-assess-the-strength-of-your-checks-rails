require "rails_helper"

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

def when_i_start_a_new_assessment
  visit 'assessments/new'
  click_button 'Start assessment'
end

def and_i_choose_a_regular_confidence_level
  choose 'Medium confidence'
  click_button 'Continue'
end

def then_i_am_told_to_choose_a_confidence_level
  expect(page).to have_content 'You must choose a confidence level'
end

def then_i_see_the_overview_screen
  expect(page).to have_content 'Your scores'
end
