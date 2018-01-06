require 'rails_helper'

describe LeagueHelper, type: :helper do
  let(:dummy_class)    { Class.new { include LeagueHelper } }
  let(:created_season) { create(:season) }
  let(:created_league) { created_season.league }

  before do
    allow_any_instance_of(LeagueHelper).to receive(:league_param).and_return(created_league.slug)
    allow_any_instance_of(LeagueHelper).to receive(:season_param).and_return(created_season.id)
  end

  context '#load_league' do
    it 'returns the league' do
      expect(load_league).to eq(created_league)
      expect(@league).to eq(created_league)
    end
  end

  context '#load_season' do
    it 'returns the season' do
      expect(load_season).to eq(created_season)
      expect(@league).to eq(created_league)
      expect(@season).to eq(created_season)
    end
  end

  context '#league' do
    it 'returns the league' do
      expect(league).to eq(created_league)
    end
  end

  context '#season' do
    it 'returns the season' do
      expect(season).to eq(created_season)
    end
  end
end
