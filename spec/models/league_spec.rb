require 'rails_helper'

describe League, type: :model do
  let(:league) { create(:league) }
  let(:user1)  { create(:user) }
  let(:user2)  { create(:user) }

  context 'relationships' do
    it { should belong_to :creator }

    context 'member and admin users' do

      context 'should have many member users' do
        it 'returns member users' do
          create(:user_league_role, :member, user: user1, league: league)
          create(:user_league_role, :member, user: user2, league: league)

          expect(league.members).to match_array([user1, user2])
        end

        it 'returns an empty array' do
          expect(league.members).to eq([])
        end
      end

      context 'should have many admin users' do
        it 'returns admin users' do
          create(:user_league_role, :admin, user: user2, league: league)

          expect(league.admins).to match_array([user2, league.creator])
        end

        it 'returns an empty array' do
          league.user_league_roles.destroy_all

          expect(league.admins).to eq([])
        end
      end
    end
    it { should have_many :seasons }
  end

  context 'validations' do
    it { should validate_presence_of :name }
    it do
      create(:league)
      should validate_uniqueness_of :name
    end
    it { should validate_presence_of :slug }
    it { should validate_presence_of :user_id }
  end

  context 'methods' do
    context '#not_part_of_league?' do
      it 'returns true' do
        expect(league.not_part_of_league?(user1)).to be true
      end

      it 'returns false' do
        create(:user_league_role, :admin, league: league, user: user2)

        expect(league.not_part_of_league?(user2)).to be false
      end
    end

    context '#not_privated?' do
      it 'returns true' do
        league.update(privated: false)

        expect(league.not_privated?).to be true
      end

      it 'returns false' do
        league.update(privated: true)

        expect(league.not_privated?).to be false
      end
    end

    context '#part_of_league?' do
      it 'returns true' do
        create(:user_league_role, :member, league: league, user: user1)

        expect(league.part_of_league?(user1)).to be true
      end

      it 'returns false' do
        expect(league.part_of_league?(user1)).to be false
      end
    end
  end
end
