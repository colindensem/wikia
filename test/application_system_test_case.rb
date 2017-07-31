# frozen_string_literal: true
require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :firefox, screen_size: [1200, 1200]

  include Devise::Test::IntegrationHelpers
end
