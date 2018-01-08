require 'rails_helper'

describe 'Admin can edit game', type: :feature do
  let(:game)   { create(:game) }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin)  { league.creator }

  before do
    stub_current_(admin)
    visit edit_league_season_game_path(league, season, game)
  end

  scenario 'redirects to league season game path - successful update' do

    fill_in 'Date', with: '01/01/1977'
    click_button 'Update Game'

    expect(current_path).to eq(league_season_game_path(league, season, game))
    expect(page).to have_content 'January 1, 1977'
  end

  scenario 'renders the edit template - unsuccessful update' do
    fill_in 'Attendees', with: ''
    click_button 'Update Game'

    expect(page).to have_button 'Update Game'
  end
end
