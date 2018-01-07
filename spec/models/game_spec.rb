require 'rails_helper'

describe Game, type: :model do
  context 'relationships' do
    it { should belong_to :season }
    it { should belong_to :creator }
  end

  context 'validations' do
    it { should validate_presence_of :attendees }
    it { should validate_presence_of :buy_in }
  end

  context 'methods' do
    let(:game) { create(:game) }
    context '#finalize!' do
      it 'changes from false to true' do
        game.update(finalized: false)

        expect {
          game.finalize!
        }.to change { game.reload.finalized }.from(false).to(true)
      end

      it 'doesnt change from true' do
        game.update(finalized: true)

        expect {
          game.finalize!
        }.to_not change { game.reload.finalized }.from(true)
      end
    end
    context '#unfinalize!' do
      it 'changes from true to false' do
        game.update(finalized: true)

        expect {
          game.unfinalize!
        }.to change { game.reload.finalized }.from(true).to(false)
      end

      it 'doesnt change from false' do
        game.update(finalized: false)

        expect {
          game.unfinalize!
        }.to_not change { game.reload.finalized }.from(false)
      end
    end
  end
end
