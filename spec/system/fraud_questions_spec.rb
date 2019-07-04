require "rails_helper"
require_relative "steps_helper"

RSpec.feature 'Fraud questions', type: :system do
  scenario 'Answer fraud questions positively' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_choose_the_fraud_link
    and_i_respond 'Yes', to_prompt: 'Do you check if the identity has been stolen or used fraudulently?', and_continue: true
    and_i_say_i_do_all_the_fraud_checks
    and_i_respond 'More than one', to_prompt: 'How many counter-fraud data sources do you check with?', and_continue: true
    and_i_respond 'Yes', to_prompt: 'Are the counter-fraud sources you use independent?', and_continue: true
    then_i_get_a_score 'XXX', 'out of 4' # TODO scoring!
  end

  scenario 'Fail to do all of the fraud checks' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_choose_the_fraud_link
    and_i_respond 'Yes', to_prompt: 'Do you check if the identity has been stolen or used fraudulently?', and_continue: true
    and_i_say_i_do_all_the_fraud_checks(nearly: true)
    then_i_get_a_score 'XXX', 'out of 4' # TODO scoring!
  end

  def and_i_choose_the_fraud_link
    click_link 'fraud-edit'
  end

  def and_i_say_i_do_all_the_fraud_checks(nearly: false)
    check "The person has not had their details stolen (even if those details have not been used fraudulently yet)"
    check "The person's identity has not been reported as stolen"
    check "The person is not at a high risk of being impersonated (for example if they’re a ‘politically exposed person’, like a politician or a judge)"
    check "The person's details do not belong to someone who has died"
    if !nearly
      check "The person's details are known by an organisation that should have a record of that person (for example an Electoral Registration Office in a local authority)"
    end
    click_button 'Continue'
  end

  def then_i_get_a_score(score, additional_text)
    expect(page).to have_content "#{score} #{additional_text}"
    click_button 'Continue'
    # expect(find('#fraud-score')).to have_text score # TODO
    # expect(find('#fraud-edit')).to have_content 'Change' # TODO
  end
end
