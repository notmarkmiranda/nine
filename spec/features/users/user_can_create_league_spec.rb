require 'rails_helper'

describe 'User can create league', type: :feature do
  let(:user) { create(:user) }

  before do
    stub_current_(user)
  end

  scenario 'redirects them to the league show page - successful create' do
    visit new_league_path

    fill_in 'League Name', with: 'Super Duper League'
    choose 'league_privated_1'
    click_button 'Create League'

    expect(current_path).to eq(league_path(League.last))
    expect(page).to have_content('Super Duper League')
  end

  scenario 'renders the new template - unsuccessful create' do
    visit new_league_path

    choose 'league_privated_1'
    click_button 'Create League'

    expect(page).to have_button('Create League')
  end
end
