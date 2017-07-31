# frozen_string_literal: true
require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  test 'visiting the index as a guest' do
    visit root_url
    #
    assert_text 'WIKIA'
    assert_selector 'a', text: 'Register'
    assert_selector 'a', text: 'Login'
  end

  test 'signup as a user' do
    visit root_url
    click_on 'Register'
    fill_in 'Email', with: 'newPlayer@example.com'
    fill_in :user_first_name, with: 'John'
    fill_in :user_last_name, with: 'Kayne'
    fill_in 'Password', with: 'password'
    fill_in :user_password_confirmation, with: 'password'

    click_on 'Sign up'

    assert_text 'Welcome! You have signed up successfully'
  end

  test 'sign in and view the index' do
    sign_in users(:adam)

    visit root_url

    assert_text 'WIKIA'
    click_on 'Account'
    assert_selector 'a', text: 'Adam Barnes'
    assert_selector 'a', text: 'Logout'
    refute_selector 'a', text: 'Login'
  end

  test 'edit my account' do
    sign_in users(:adam)

    visit edit_user_registration_path
    fill_in 'Email', with: 'player0@example.com'
    fill_in :user_first_name, with: 'AdamNew'
    fill_in :user_last_name, with: 'BarnsNew'
    fill_in :user_current_password, with: 'password'
    click_on 'Update'

    assert_text 'Your account has been updated successfully'
    click_on 'Account'
    assert_text 'AdamNew BarnsNew'
  end
end
