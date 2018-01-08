require 'rails_helper'

describe 'Admin can schedule game', type: :feature do
  let(:season) { create(:season) }
  let(:league) { season.league }
  let(:admin)  { league.creator }

  before do
    stub_current_(admin)
    visit new_league_season_game_path(league, season)
    fill_in 'Date', with: '06/12/1981'
    fill_in 'Buy In', with: '100'
  end

  scenario 'redirects to league season game path - successful create' do

    fill_in 'Attendees', with: '25'
    click_button 'Schedule Game'

    expect(current_path).to eq(league_season_game_path(league, season, Game.last))
    expect(page).to have_content 'December 6, 1981'
    expect(page).to have_content 'Buy In: $100.00'
  end

  scenario 'renders the new template - unsuccessful create' do
    click_button 'Schedule Game'

    expect(page).to have_button 'Schedule Game'
  end
end
