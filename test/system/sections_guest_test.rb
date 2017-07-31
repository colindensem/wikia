# frozen_string_literal: true
require 'application_system_test_case'

class SectionsGuestTest < ApplicationSystemTestCase
  def setup
    @article = articles(:java)
  end

  test 'visit the sections index as guest' do
    visit article_sections_url(@article)
    assert_text 'You need to sign in or sign up before continuing'
  end

  test 'creating an article section' do
    visit new_article_section_url(@article)
    assert_text 'You need to sign in or sign up before continuing'
  end

  test 'editing an article section' do
    section = sections(:java_one)
    visit edit_article_section_url(section.article, section)
    assert_text 'You need to sign in or sign up before continuing'
  end

  test 'view an article section' do
    section = sections(:java_one)
    visit article_sections_url(section.article, section)
    assert_text 'You need to sign in or sign up before continuing'
  end
end
