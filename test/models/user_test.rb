# frozen_string_literal: true
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:adam)
  end
  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without first name' do
    @user.first_name = nil
    refute @user.valid?, 'saved without first_name'
    assert_not_nil @user.errors[:first_name], 'no validation error for name present'
  end

  test 'invalid without last name' do
    @user.last_name = nil
    refute @user.valid?, 'saved without last_name'
    assert_not_nil @user.errors[:last_name], 'no validation error for name present'
  end

  test '#name' do
    assert_equal @user.name, 'Adam Barnes'
  end
end
