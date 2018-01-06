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

  context 'methods'
end
