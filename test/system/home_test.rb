# frozen_string_literal: true
require 'application_system_test_case'

class HomePageTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit root_url
    #
    assert_text 'WIKIA'
    assert_text 'Initital WIKIA home page'
    assert_selector 'h1', text: 'Welcome'
  end
end
