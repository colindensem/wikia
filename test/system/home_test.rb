# frozen_string_literal: true
require 'application_system_test_case'

class HomePageTest < ApplicationSystemTestCase
  test 'visiting the index' do
    visit root_url
    #
    assert_text 'WIKIA'
    assert_text 'It\'s time to find those code examples'
    assert_selector 'h1', text: 'Hello'
  end

  test 'navigate to articles' do
    visit root_url
    assert_selector 'a', text: 'Articles'
    click_on 'Articles'
    assert_selector 'h1', text: 'Articles'
  end

  test 'navigate to author page' do
    author = users(:eve)
    sign_in author
    visit root_url
    click_on 'Account'
    click_on 'My Content'
    assert_selector 'h1', text: author.name
    visit root_url
    click_on 'Account'
    click_on author.name
    assert_selector 'h1', text: author.name
  end

  test 'search by exact title' do
    search = articles(:java)
    visit root_url
    fill_in 'search', with: search.title
    click_button 'Search'

    assert_selector 'div', class: 'mui--text-headline'
    assert_selector 'a', text: search.title

    refute_text articles(:ada).title
  end

  test 'search by language' do
    search = articles(:elixir)
    visit root_url
    fill_in 'search', with: search.title
    click_button 'Search'

    assert_selector 'div', class: 'mui--text-headline'
    assert_selector 'a', text: search.title

    refute_text articles(:ada).title
  end

  test 'search by impossible term' do
    visit root_url
    fill_in 'search', with: 'supercalifragilisticexpialidocious'
    click_button 'Search'

    assert_selector 'div', class: 'mui--text-headline'
    assert_selector 'div', text: 'No Articles Found'
  end
end
