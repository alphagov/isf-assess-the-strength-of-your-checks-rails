require "rails_helper"
require_relative "steps_helper"

RSpec.feature 'Activity questions', type: :system do
  scenario 'Answer activity questions positively' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_choose_the_activity_link
    and_i_respond 'Yes', to_prompt: 'Do you check if the identity has existed over time?', and_continue: true
    and_i_respond 'Yes', to_prompt: 'Did the person have to prove their identity before they interacted with the organisation?'
    check 'Using their own identity checking process'
    click_button 'Continue'
    and_i_respond 'The last 12 months', to_prompt: 'Over what period of time did you find the interactions?', and_continue: true
    and_i_respond 'Yes', to_prompt: "Do you check if the interactions you've found are interactions you'd expect users to have?", and_continue: true
    then_i_get_a_score 'XXX', 'out of 4' # TODO scoring!
  end
end

def and_i_choose_the_activity_link
  click_link 'activity-edit'
end

def then_i_get_a_score(score, additional_text)
  expect(page).to have_content "#{score} #{additional_text}"
  click_button 'Continue'
  # expect(find('#activity-score')).to have_text score # TODO
  # expect(find('#activity-edit')).to have_content 'Change' # TODO
end
