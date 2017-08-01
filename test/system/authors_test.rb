# frozen_string_literal: true
require 'application_system_test_case'

class AuthorsTest < ApplicationSystemTestCase
  setup do
    @author = users(:eve)
  end

  test 'visit author page as a guest' do
    visit author_url(@author)
    assert_text 'You need to sign in or sign up before continuing'
  end

  test 'visiting the author page' do
    sign_in @author
    visit author_url(@author)
    #
    assert_text 'WIKIA'
    assert_selector 'h1', text: @author.name
  end

  test 'vist a different authors page' do
    sign_in @author
    visit author_url(users(:adam))

    assert_text 'No access to that author.'
  end

  test 'navigate to articles' do
    sign_in @author
    visit author_url(@author)
    assert_selector 'a', text: 'Ada Lovelace'
    assert_selector 'a', text: 'Can it be functional and procedural'
    click_on 'Ada Lovelace'
    assert_selector 'h1', text: 'Ada Lovelace'
  end

  test 'search is available' do
    sign_in @author
    search = articles(:elixir)
    visit author_url(@author)

    fill_in 'search', with: search.title
    click_button 'Search'

    assert_selector 'div', class: 'mui--text-headline'
    assert_selector 'a', text: search.title

    refute_text articles(:ada).title
  end
end
