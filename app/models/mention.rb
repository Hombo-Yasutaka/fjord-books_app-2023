# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :mentioning_report, class_name: 'Report', foreign_key: 'mentioning_id', inverse_of: :mentionings
  belongs_to :mentioned_report, class_name: 'Report', foreign_key: 'mentioned_id', inverse_of: :mentioneds

  validates :mentioning_id, uniqueness: { scope: :mentioned_id }
end
