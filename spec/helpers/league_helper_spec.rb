require 'rails_helper'

describe LeagueHelper, type: :helper do
  let(:dummy_class)    { Class.new { include LeagueHelper } }
  let(:created_league) { create(:league) }

  before do
    allow_any_instance_of(LeagueHelper).to receive(:league_param).and_return(created_league.slug)
  end

  context '#load_league' do
    it 'returns the league' do
      expect(load_league).to eq(created_league)
      expect(@league).to eq(created_league)
    end
  end

  context '#league' do
    it 'returns the league' do
      expect(league).to eq(created_league)
    end
  end
end
