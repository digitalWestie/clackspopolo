require 'rails_helper'

feature 'As a user who wants to add content to the site' do
  #let!(:user) { FactoryGirl.create(:user) }
  scenario 'I cannot access organizations until I have signed up and signed in', js:true do
    visit '/admin/organizations/'
    expect(current_path).to eql(new_admin_session_path)
  end
end