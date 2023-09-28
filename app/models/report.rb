# frozen_string_literal: true

class Report < ApplicationRecord
  has_many :comments, as: :imageable, dependent: :destroy
end
