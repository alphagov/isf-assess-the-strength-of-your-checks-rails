require 'rails_helper'

RSpec.describe 'New assessment page', type: :system do
  it 'shows the main heading and a Start button' do
    visit 'assessments/new'
    expect(page).to have_content 'Assess an identity check'
    expect(page).to have_button 'Start assessment'
  end
end
