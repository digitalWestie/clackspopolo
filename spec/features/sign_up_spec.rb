require 'rails_helper'

feature 'As a user who wants to add content to the site' do
  #let!(:admin) { FactoryGirl.create(:admin) }

  scenario 'can sign up with valid input', js:false do
    visit '/admin/sign_up/'

    fill_in 'Email',                      with: 'jimmy@example.com'
    fill_in 'admin_password',              with: 'passwurd'
    fill_in 'admin_password_confirmation', with: 'passwurd'
    click_button 'Sign up'

    expect(Admin.where(email: "jimmy@example.com").exists?).to eql(true)
    expect(current_path).to eql(root_path)
  end

end