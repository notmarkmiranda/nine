require 'rails_helper'

describe 'League creation creates initial season', type: :request do
  let(:user)  { create(:user) }
  let(:attrs) { attributes_for(:league) }

  before do
    stub_current_(user)
  end

  it 'creates a league and season' do
    expect {
      post '/leagues', params: { league: attrs }
    }.to change(League, :count).by(1)
      .and change(Season, :count).by(1)
  end
end
