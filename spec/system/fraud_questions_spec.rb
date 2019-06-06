require "rails_helper"
require_relative "steps_helper"

RSpec.feature 'Fraud questions', type: :system do
  scenario 'Answer fraud questions positively' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_choose_the_fraud_link
    and_i_respond 'Yes', to_prompt: 'Do you check if the identity has been stolen or used fraudulently?', and_continue: true
    check "The person's identity has not been reported as stolen"
    click_button 'Continue'
    and_i_respond 'More than one', to_prompt: 'How many counter-fraud data sources do you check with?', and_continue: true
    and_i_respond 'Yes', to_prompt: 'Are the counter-fraud sources you use independent?', and_continue: true
    then_i_get_a_score 'XXX', 'out of 4' # TODO scoring!
  end
end

def and_i_choose_the_fraud_link
  click_link 'fraud-edit'
end

def then_i_get_a_score(score, additional_text)
  expect(page).to have_content "#{score} #{additional_text}"
  click_button 'Continue'
  # expect(find('#fraud-score')).to have_text score # TODO
  # expect(find('#fraud-edit')).to have_content 'Change' # TODO
end
