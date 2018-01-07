require 'rails_helper'

describe Season, type: :model do
  context 'relationships' do
    it { should belong_to :league }
    it { should have_many :games }
  end

  context 'validations' do
    it { should validate_presence_of :league_id }
  end

  context 'methods' do
    let(:season) { create(:season) }
    context '#activate!' do
      it 'changes from false to true' do
        season.update(active: false)

        expect {
          season.activate!
        }.to change { season.reload.active }.from(false).to(true)
      end

      it 'doesnt not change from true' do
        season.update(active: true)

        expect {
          season.activate!
        }.to_not change { season.reload.active }.from(true)
      end
    end

    context '#deactivate!' do
      it 'changes from true to false' do
        season.update(active: true)

        expect {
          season.deactivate!
        }.to change { season.reload.active }.from(true).to(false)
      end

      it 'doesnt not change from true' do
        season.update(active: false)

        expect {
          season.deactivate!
        }.to_not change { season.reload.active }.from(false)
      end
    end
  end
end
