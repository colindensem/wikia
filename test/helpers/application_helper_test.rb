# frozen_string_literal: true
require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test '#current_author?/1 true for author' do
    article = articles(:one)
    user    = users(:adam)
    assert current_author?(article, user)
  end
  test '#current_author?/1 false for another author' do
    article = articles(:one)
    user    = users(:eve)
    refute current_author?(article, user)
  end
  test '#current_author?/1 false for no author' do
    article = articles(:one)
    user    = {}
    refute current_author?(article, user)
  end
end
