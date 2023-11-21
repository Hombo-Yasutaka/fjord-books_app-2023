# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :comments, as: :imageable, dependent: :destroy
  belongs_to :user, foreign_key: 'owner', inverse_of: :reports
end
