# frozen_string_literal: true
require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:adam)

    @section = sections(:java_one)
    @article = @section.article
  end

  test 'should get index' do
    get article_sections_url(@article)
    assert_response :success
  end

  test 'should get new' do
    get new_article_section_url(@article)
    assert_response :success
  end

  test 'should create section' do
    assert_difference('Section.count') do
      post article_sections_url(@article), params: { section: { content: @section.content, title: @section.title + Time.now.to_i.to_s } }
    end

    assert_redirected_to article_sections_url(@article)
  end

  test 'should show section' do
    get article_section_url(@section.article, @section)
    assert_response :success
  end

  test 'should get edit' do
    get edit_article_section_url(@section.article, @section)
    assert_response :success
  end

  test 'should update section' do
    patch article_section_url(@section.article, @section), params: { section: { content: @section.content, title: @section.title + Time.now.to_i.to_s } }
    assert_redirected_to article_sections_url(@section.article)
  end

  test 'should destroy section' do
    assert_difference('Section.count', -1) do
      delete article_section_url(@section.article, @section)
    end

    assert_redirected_to article_sections_url(@article)
  end
end
