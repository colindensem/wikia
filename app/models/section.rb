# frozen_string_literal: true
class Section < ApplicationRecord
  belongs_to :article

  validates :title, :content, presence: true
  validates :title, uniqueness: { scope: :article_id }
end
