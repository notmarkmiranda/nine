require 'rails_helper'

describe 'Visitor can sign up', type: :feature do
  scenario 'redirects to dashboard path - successful sign up' do
    visit sign_up_path

    fill_in 'Email Address', with: 'test@example.com'
    fill_in 'First Name', with: 'Mark'
    fill_in 'Last Name', with: 'Miranda'
    fill_in 'Password', with: 'password'
    click_button 'Sign Up!'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content 'test@example.com'
  end
end
