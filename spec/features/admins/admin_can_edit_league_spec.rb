require 'rails_helper'

describe 'Admin can edit a league', type: :feature do
  let(:league) { create(:league, :public) }
  let(:admin)  { league.creator }

  before do
    stub_current_(admin)
  end

  scenario 'redirects to the league path - successful update' do
    visit edit_league_path(league)

    fill_in 'League Name', with: 'New League Name'
    choose 'league_privated_0'
    click_button 'Update League'

    expect(current_path).to eq(league_path(league.reload))
    expect(page).to have_content('New League Name')
  end

  scenario 'renders the edit template - unsuccessful update' do
    visit edit_league_path(league)

    fill_in 'League Name', with: ''
    click_button 'Update League'

    expect(page).to have_button('Update League')
  end
end
