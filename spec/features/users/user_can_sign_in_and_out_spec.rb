require 'rails_helper'

describe 'User can sign in', type: :feature do
  let(:user) { create(:user) }

  scenario 'and is redirected to the dashboard path and can sign out' do
    visit sign_in_path

    fill_in 'Email Address', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content user.email
    expect(page).to have_link 'Sign Out'
    expect(page).to_not have_link 'Sign In'

    click_link 'Sign Out'
    expect(current_path).to eq(root_path)
  end
end
