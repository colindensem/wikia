# frozen_string_literal: true
class Article < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  has_many :sections

  validates :author, presence: true
  validates :title, :excerpt, :language, :body, presence: true

  validates :title, uniqueness: true, allow_blank: true

  scope :search, ->(terms) {
    return if terms.blank?
    terms.downcase.split(' ').map do |term|
      where('LOWER(title) LIKE ?', "%#{term}%")
        .or(Article.where('LOWER(language) LIKE ?', "%#{term}%"))
    end.flatten.uniq
  }
end
