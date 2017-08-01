# frozen_string_literal: true
require 'application_system_test_case'

class SectionsTest < ApplicationSystemTestCase
  def setup
    sign_in users(:adam)
    @article = articles(:java)
    @section = sections(:java_one)
  end

  test 'access sections from article' do
    visit article_path(@article)
    click_on 'Edit Sections'
    assert_text @section.title
    assert_selector 'a', text: @article.title
    assert_selector 'a', text: 'NEW SECTION'
  end

  test 'show sections for my article only' do
    eves_section = sections(:ada_one)
    visit article_sections_path(@article)

    assert_text @section.title
    refute_text eves_section.title
    assert_selector 'a', text: @article.title
    assert_selector 'a', text: 'NEW SECTION'
  end

  test 'creating an article section' do
    visit article_sections_url(@article)
    click_on 'New Section'

    fill_in 'Title', with: 'New Section Title'
    fill_in 'Content', with: 'Ut id quis minim ipsum laboris ea ut exercitation. Irure commodo anim nisi adipisicing aute nostrud incididunt consequat do ullamco consectetur. Magna nisi mollit sit do ad duis aliquip commodo aliquip duis irure veniam. Laborum reprehenderit commodo ipsum ad in non laboris esse culpa. Dolore nisi amet laboris cupidatat adipisicing labore et aute. Occaecat est dolor et culpa. Do duis est dolore commodo mollit minim reprehenderit adipisicing non velit pariatur ea nisi.'
    click_on 'Create Section'

    assert_selector 'h3', text: 'New Section Title'
  end

  test 'editing an article section' do
    section = sections(:java_one)
    visit edit_article_section_url(section.article, section)
  end

  test 'view one of my article sections' do
    section = sections(:java_one)
    visit article_sections_url(section.article, section)
    assert_selector 'h3', section.title
  end

  test 'view any article section' do
    section = sections(:ruby_one)
    visit article_sections_url(section.article, section)
    assert_selector 'h3', section.title
  end

  test 'edit another authors section' do
    eves_article = articles(:ada)
    eves_section = sections(:ada_one)
    visit edit_article_section_path(eves_article, eves_section)

    assert_text 'No access to that article'
  end
end
