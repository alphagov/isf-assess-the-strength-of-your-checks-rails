require "rails_helper"
require_relative "steps_helper"

RSpec.feature 'Verification questions', type: :system do
  scenario 'Answer verification questions positively' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_choose_the_verification_link
    and_i_respond 'Yes', to_prompt: 'Do you check the person is the same person they’re claiming to be?', and_continue: true
    check 'Check the person physically matches the photo on the evidence'
    check "Check the person’s biometric information (such as their iris or their fingerprints) matches what's on the evidence"
    check 'Ask them to complete ‘knowledge-based verification’ (KBV) challenges'
    click_button 'Continue'
    and_i_respond 'Yes', to_prompt: 'Do you check someone physically matches the photo on the evidence in person?', and_continue: true
    and_i_respond 'Yes', to_prompt: 'Has the person doing the check been taught how to detect impostors?', and_continue: true
    and_i_respond 'Every year', to_prompt: 'How often do they refresh their training?', and_continue: true
    check 'Make sure the person whose identity is being checked is present'
    click_button 'Continue'
    and_i_respond 'Yes', to_prompt: 'Does you use a system?', and_continue: true
    check "It makes sure the image or video has not been intercepted and reused ('replayed')"
    click_button 'Continue'
    and_i_respond 'Yes', to_prompt: 'Can you properly see the person in the image or video?', and_continue: true
    check 'It makes sure the biometric information has not been tampered with (if it was taken from a piece of evidence)'
    click_button 'Continue'
    and_i_respond 'Your system does a basic liveness test', to_prompt: 'How does the system check the person is real?', and_continue: true
    check "The system checks if someone's using an artefact to pretend to be someone else (for example holding up a photo)"
    click_button 'Continue'
    check "The number of false matches and non-matches in your system are appropriate for your security and usability needs"
    click_button 'Continue'
    and_i_respond 'Yes', to_prompt: 'Is the biometric information captured under ‘controlled conditions’?', and_continue: true
    and_i_respond 'Static', to_prompt: 'Are the KBV questions ‘static’ or ‘dynamic’?', and_continue: true
    and_i_respond 'Yes', to_prompt: 'Do you ask someone to complete low quality KBV challenges?', and_continue: true
    and_i_respond 'Yes', to_prompt: 'Do you ask someone to complete medium quality KBV challenges?', and_continue: true
    and_i_respond 'Yes', to_prompt: 'Do you ask someone to complete high quality KBV challenges?', and_continue: true
    and_i_respond 'Multiple choice', to_prompt: 'Do you ask multiple or single choice KBV questions?'
    and_i_respond '8 or more', to_prompt: 'Do you ask multiple or single choice KBV questions?', and_continue: true
    then_i_get_a_score 'XXX', 'out of 4' # TODO scoring!
  end

  def and_i_choose_the_verification_link
    click_link 'verification-edit'
  end

  def then_i_get_a_score(score, additional_text)
    expect(page).to have_content "#{score} #{additional_text}"
    click_button 'Continue'
    # expect(find('#verification-score')).to have_text score # TODO
    # expect(find('#verification-edit')).to have_content 'Change' # TODO
  end
end
