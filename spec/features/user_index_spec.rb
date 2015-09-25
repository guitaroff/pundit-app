require 'rails_helper'
require 'support/features/session_helper'
require 'support/database_cleaner'
include Features::SessionHelpers

feature 'User index page', :devise do
  scenario 'user sees own email address' do
    user = FactoryGirl.create(:user, :admin)
    login_as(user, scope: :user)
    visit users_path
    expect(page).to have_content user.email
  end
end
