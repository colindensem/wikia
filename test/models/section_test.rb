# frozen_string_literal: true
require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  def setup
    @user = users(:adam)
    @article = articles(:java)
    @section = sections(:java_one)
  end

  test 'valid section' do
    assert @section.valid?
  end

  test 'section has author' do
    assert_equal @section.article, @article
  end

  test 'invalid without article' do
    @section.article = nil
    refute @section.valid?, 'saved without article'
    assert_not_nil @section.errors[:author], 'no validation error for article present'
  end

  %i(title content).map do |field|
    test "is invalid without a #{field}" do
      @section[field] = nil
      refute @section.valid?, "saved without #{field}"
      assert_not_nil @section.errors[field], 'no validation error for field present'
    end
  end

  test 'invalid with a duplicate title in article' do
    doppleganger = sections(:java_one).dup
    refute doppleganger.valid?, 'saved with duplicate title'
    assert_not_nil doppleganger.errors[:title], 'no validation error for duplicate title present'
  end

  test 'valid with a duplicate title different article' do
    new_section = sections(:java_one)
    new_section.article = articles(:ada)
    assert new_section.valid?, 'saved with duplicate title'
  end
end
