# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  belongs_to :user, foreign_key: 'owner', inverse_of: :comments

  validates :content, presence: true
end
