Given /^I am logged in as a user$/ do
  @current_user = Admin.create!(:email => 'example@example.com', :password => 'password')
  login_as(@current_user, :scope => :admin)
end