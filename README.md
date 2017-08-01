# WIKIA

A conceptual application for a simple intranet wiki/document base

## Requirements

* A wiki system for an intranet with multiple users.
* Used to store internal documentation & code snippets.
* Provide a basic search function on title and language category.
* Allow users to join and manage a range of articles.

## Usage Notes

* Anyone can search & view any article.
* Guests can create an account to become a registered user.
* Registered users can manage their own article content via the account link in the navigation bar.
* An article is compromised of itself and many sections.
* Article and sections support the use of markdown for general formatting and code rendering.

![Alt text](/screenshot.png?raw=true "Alpha Screenshot")


## Development

Written using Rails 5.1

Report all issues via the [issue tracker](https://github.com/colindensem/wikia/issues) on github.

### Local Development

Requirements:
 * Ruby/Bundler
 * NodeJS/Yarn
 * SQLITE3
 * SystemTest/Firefox & geckodriver(1)

After cloning the repository, run locally, from your terminal run:
```
bundle install
bundle exec rake db:create:all
yarn
bundle exec rails s
```

Visit the site at <a href="http://localhost:3000" target="\_blank">localhost:3000</a>

### Testing:

Unit and system tests under folder `test`, you can run them with:
```
bundle exec rails test
bundle exec rails test:system
```


# Notes
1 Rails5 system tests run via selenium. This invokes a browser to perform the tests. This project uses firefox, you'll need the geckodriver. Please download the server from [Github Mozilla](https://github.com/mozilla/geckodriver/releases) and place it somewhere on your PATH. More info at [Mozilla Developer Site](https://developer.mozilla.org/en-US/docs/Mozilla/QA/Marionette/WebDriver).