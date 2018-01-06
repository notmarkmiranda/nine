require 'rails_helper'

describe User, type: :model do
  context 'relationships' do
    it { should have_many :created_leagues }
    it { should have_many :user_league_roles }
    it { should have_many :leagues }

    context 'member and admin leagues' do
      let(:user) { create(:user) }
      let(:league1) { create(:league) }
      let(:league2) { create(:league) }
      context 'should have many member leagues' do
        it 'returns member leagues' do
          create(:user_league_role, :member, league: league1, user: user)
          create(:user_league_role, :member, league: league2, user: user)

          expect(user.member_leagues).to match_array([league1, league2])
        end

        it 'returns an empty array when none exist' do
          expect(user.member_leagues).to eq([])
        end
      end

      context 'should have many admin leagues' do
        it 'returns admin leagues' do
          create(:user_league_role, :admin, league: league2, user: user)

          expect(user.admin_leagues).to match_array([league2])
        end

        it 'returns an empty array when none exist' do
          expect(user.admin_leagues).to eq([])
        end
      end
    end
    it { should have_many :non_league_games }
  end

  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end
  context 'methods'
end
