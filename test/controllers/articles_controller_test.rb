# frozen_string_literal: true
require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:adam)
    @article = articles(:one)
  end

  test 'should get index' do
    get articles_url
    assert_response :success
  end

  test 'should get new' do
    get new_article_url
    assert_response :success
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post articles_url, params: { article: { body: @article.body, excerpt: @article.excerpt, language: @article.language, title: @article.title + Time.now.to_i.to_s } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test 'should show article' do
    get article_url(@article)
    assert_response :success
  end

  test 'should get edit' do
    get edit_article_url(@article)
    assert_response :success
  end

  test 'should update article' do
    patch article_url(@article), params: { article: { body: @article.body, excerpt: @article.excerpt, language: @article.language, title: @article.title + Time.now.to_i.to_s } }
    assert_redirected_to article_url(@article)
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
