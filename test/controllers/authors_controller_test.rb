# frozen_string_literal: true
require 'test_helper'

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @author = users(:adam)
    sign_in @author
    @article = articles(:java)
  end

  test 'should get show' do
    get author_url(@author)
    assert_response :success
  end
end
