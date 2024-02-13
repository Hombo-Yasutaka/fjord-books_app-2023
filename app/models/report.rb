# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :mentionings, class_name: 'Mention', foreign_key: 'mentioning_id', dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioneds, class_name: 'Mention', foreign_key: 'mentioned_id', dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioning_reports, through: :mentionings, source: :mentioned_report
  has_many :mentioned_reports, through: :mentioneds, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def update_mentions(report_params, reports_url)
    mentioning_ids = []
    report_params[:content].scan(%r{#{reports_url}/([1-9]\d*)}) do |s|
      mentioning_ids << s[0].to_i
    end
    mentioning_ids.uniq!
    existing_mentioned_ids = Report.where(id: mentioning_ids).pluck(:id)
    if existing_mentioned_ids.present?
      begin
        existing_mentioned_ids.each do |mentioned_id|
          Mention.create!(mentioning_id: id, mentioned_id: mentioned_id)
        end
        true
      rescue
        false
      end
    end
  end

end
