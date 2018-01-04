require 'rails_helper'

describe 'Created league also creates Admin ULR', type: :request do
  let(:user)  { create(:user) }
  let(:attrs) { attributes_for(:league) }

  before do
    stub_current_(user)
  end

  it 'creates an admin ULR' do
    expect {
      post '/leagues', params: { league: attrs }
    }.to change(UserLeagueRole, :count).by(1)
      .and change(League, :count).by(1)
  end
end
