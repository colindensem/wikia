# frozen_string_literal: true
require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @user = users(:adam)
    @article = articles(:java)
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
    doppleganger = articles(:java).dup
    refute doppleganger.valid?, 'saved with duplicate title'
    assert_not_nil doppleganger.errors[:title], 'no validation error for duplicate title present'
  end

  test '#search by impossible term' do
    results = Article.search('Supercalifragilisticexpialidocious')
    assert_equal results.size, 0
  end

  test '#search with nothing gives everything' do
    results = Article.search('')
    assert_equal results.size, 5
  end

  test '#search by a language' do
    results = Article.search('elixir')
    assert_equal results.size, 1
    assert_includes results, articles(:elixir)
    refute_includes results, articles(:java)
  end

  test '#search for term in multiple titles' do
    results = Article.search('functional')
    assert_equal results.size, 2
    assert_includes results, articles(:elixir)
    assert_includes results, articles(:ruby)

    refute_includes results, articles(:java)
  end

  test '#search for multiple languages' do
    results = Article.search('ada java')
    assert_equal results.size, 2
    assert_includes results, articles(:ada)
    assert_includes results, articles(:java)

    refute_includes results, [
      articles(:csharp),
      articles(:ruby),
      articles(:elixir),
    ]
  end

  test '#search multiple hits to returns uniq' do
    results = Article.search('functional ruby')
    assert_equal results.size, 2
  end

  test '#search case insensitive' do
    results = Article.search('RUBY')
    assert_equal results.size, 1
  end
end
