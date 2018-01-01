require 'rails_helper'

describe 'User can edit profile', type: :feature do
  let(:user) { create(:user) }

  before do
    stub_current_(user)
  end

  scenario 'redirects them to dashboard path - successful update' do
    visit edit_profile_path

    fill_in 'Email Address', with: 'MARK!'
    click_button 'Update Profile'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('MARK!')
  end
end
