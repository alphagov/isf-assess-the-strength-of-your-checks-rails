def and_i_respond(response_choice, to_prompt: '', and_continue: false)
  if to_prompt.present?
    expect(page).to have_content to_prompt
  end
  choose response_choice
  click_button 'Continue' if and_continue
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
