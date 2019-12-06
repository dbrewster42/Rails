# require 'rails_helper'
# feature "guest user creates an account" do
#   scenario "successfully creates a new user account" do
#     visit new_user_path
#     fill_in "user[first]", with: "shane"
#     fill_in "user[last]", with: "chang"
#     fill_in "user_email", with: "schang@codingdojo.com"
#     click_button "Create User"
#     expect(page).to have_content "User successfully created"
#   end
# end
require 'rails_helper'
feature "User creates an account" do
  before(:each) do 
    visit new_user_path
  end
  scenario "successfully creates a new user account" do
    fill_in "user[first]", with: "shane"
    fill_in "user_last_name", with: "chang"
    fill_in "user_email", with: "schang@codingdojo.com"
    click_button "Create User"
    expect(page).to have_content "Welcome, shane"
    # We'll be redirecting to the user show page is user succesfully created
    # expect(page).to have_current_path(user_path(User.last))    
  end
  scenario "unsuccessfully creates a new user account" do 
    click_button "Create User"
    expect(current_path).to eq(new_user_path)
  end
  scenario "doesn't fill out first name field" do 
    fill_in "user_last_name", with: "shane"
    fill_in "user_email", with: "schang@codingdojo.com"
    click_button "Create User"
    expect(page).to have_content "First can't be blank"
  end
  scenario "doesn't fill out last name field" do 
  	fill_in "user[first]", with: "shane"   
    fill_in "user_email", with: "schang@codingdojo.com"
    click_button "Create User"
    expect(page).to have_content "Last can't be blank"
  end
  scenario "email is invalid" do 
  	fill_in "user[first]", with: "shane"
    fill_in "user_last_name", with: "chang"
    fill_in "user_email", with: "schangcodingdojo.com"
    click_button "Create User"
    expect(page).to have_current_path(new_user_path)
    expect(page).to have_content "invalid"
  end
end