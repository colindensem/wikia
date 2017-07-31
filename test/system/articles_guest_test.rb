# frozen_string_literal: true
require 'application_system_test_case'

class ArticlesGuestTest < ApplicationSystemTestCase
  test 'visit the articles index' do
    visit articles_url
    #
    assert_text 'WIKIA'
    assert_text 'Articles'
    refute_selector 'a', text: 'New Article'
    refute_selector 'a', text: 'Edit'
    refute_selector 'a', text: 'Destroy'
  end

  test 'creating an article' do
    visit new_article_url
    assert_text 'You need to sign in or sign up before continuing'
  end

  test 'editing an article' do
    article = articles(:one)
    visit edit_article_url(article)
    assert_text 'You need to sign in or sign up before continuing'
  end

  test 'view an article' do
    @article = articles(:one)
    visit articles_url
    click_on @article.title
    assert_selector 'h1', text: @article.title
    refute_selector 'a', text: 'Edit'
  end
end
