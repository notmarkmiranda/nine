require 'rails_helper'

describe Season, type: :model do
  context 'relationships' do
    it { should belong_to :league }
    it { should have_many :games }
  end

  context 'validations' do
    it { should validate_presence_of :league_id }
  end

  context 'methods'
end
