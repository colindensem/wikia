# frozen_string_literal: true
require 'application_system_test_case'

class ArticlesTest < ApplicationSystemTestCase
  def setup
    sign_in users(:adam)
    @article = articles(:java)
  end

  test 'view by language' do
    visit articles_path

    click_on 'Ada'

    assert_selector 'h1', text: 'Articles'
    assert_text 'Ada Lovelace'
    refute_text 'Was I first'
  end

  test 'search from list of articles' do
    search = articles(:java)

    visit articles_path
    fill_in 'search', with: search.title
    click_button 'Search'

    assert_selector 'div', class: 'mui--text-headline'
    assert_selector 'a', text: search.title
    refute_text articles(:ada).title
  end

  test 'view an article' do
    article = articles(:csharp)
    visit article_path(article)

    assert_selector 'strong', text: 'ternary'
    assert_selector 'em', text: 'case'
  end

  test 'view an article with markdown sections' do
    article = articles(:ruby)
    visit article_path(article)

    # checking for code tags implies markdown->coderay has processed
    # not ideal #TODO improve
    assert_selector 'div', class: 'CodeRay'
  end

  test 'creating an article' do
    visit articles_path

    click_on 'New Article'

    fill_in 'Title', with: 'New Journey'
    fill_in 'Language', with: 'Ruby'
    fill_in 'Excerpt', with: 'All about the new system testing in rails5'
    fill_in 'Body', with: 'Ut id quis minim ipsum laboris ea ut exercitation. Irure commodo anim nisi adipisicing aute nostrud incididunt consequat do ullamco consectetur. Magna nisi mollit sit do ad duis aliquip commodo aliquip duis irure veniam. Laborum reprehenderit commodo ipsum ad in non laboris esse culpa. Dolore nisi amet laboris cupidatat adipisicing labore et aute. Occaecat est dolor et culpa. Do duis est dolore commodo mollit minim reprehenderit adipisicing non velit pariatur ea nisi.'
    click_on 'Create Article'

    assert_selector 'h1', text: 'New Journey'
  end

  test 'updating an article' do
    visit article_path(@article)
    assert_selector 'h1', text: @article.title
    click_on 'Edit Article'

    fill_in 'Title', with: 'New Journey'
    fill_in 'Language', with: 'Ruby'
    fill_in 'Excerpt', with: 'All about the new system testing in rails5'
    fill_in 'Body', with: 'Ut id quis minim ipsum laboris ea ut exercitation. Irure commodo anim nisi adipisicing aute nostrud incididunt consequat do ullamco consectetur. Magna nisi mollit sit do ad duis aliquip commodo aliquip duis irure veniam. Laborum reprehenderit commodo ipsum ad in non laboris esse culpa. Dolore nisi amet laboris cupidatat adipisicing labore et aute. Occaecat est dolor et culpa. Do duis est dolore commodo mollit minim reprehenderit adipisicing non velit pariatur ea nisi.'
    click_on 'Update Article'

    assert_selector 'h1', text: 'New Journey'
  end

  test 'updating another authors article' do
    eves_article = articles(:ada)
    visit edit_article_path(eves_article)

    assert_text 'No access to that article'
  end
end
