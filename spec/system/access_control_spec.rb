require "rails_helper"
require_relative "steps_helper"

RSpec.feature 'Access control for assessments and related data', type: :system do
  scenario 'Load up another an assessment created by another user' do
    when_i_start_a_new_assessment
    and_i_choose_a_regular_confidence_level
    and_i_record_the_assessment_uri
    and_i_start_a_new_session
    then_i_cannot_see_that_assessment
  end
end

def and_i_start_a_new_session
  Capybara.current_session.reset!
end

def and_i_record_the_assessment_uri
  @assessment_uri = current_url
end

def then_i_cannot_see_that_assessment
  assert_raises(ActiveRecord::RecordNotFound) do
    visit @assessment_uri
  end
end
