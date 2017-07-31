# frozen_string_literal: true
require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:adam)
    @article = articles(:one)
  end

  test 'valid article' do
    assert @article.valid?
  end

  test 'article has author' do
    assert_equal @article.author, @user
  end

  test 'invalid without author' do
    @article.author = nil
    refute @article.valid?, 'saved without author'
    assert_not_nil @article.errors[:author], 'no validation error for author present'
  end

  %i(title language excerpt body).map do |field|
    test "is invalid without a #{field}" do
      @article[field] = nil
      refute @article.valid?, "saved without #{field}"
      assert_not_nil @article.errors[field], 'no validation error for field present'
    end
  end

  test 'invalid with a duplicate title' do
    doppleganger = articles(:one).dup
    refute doppleganger.valid?, 'saved with duplicate title'
    assert_not_nil doppleganger.errors[:title], 'no validation error for duplicate title present'
  end
end
