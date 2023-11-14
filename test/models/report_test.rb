# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    user1 = User.new
    user2 = User.new
    report = user1.reports.new
    assert report.editable?(user1)
    assert_not report.editable?(user2)
  end

  test 'created_on' do
    report = Report.new(created_at: Time.zone.now)
    assert_instance_of Date, report.created_on
  end

  test 'save_mentions' do
    user1 = User.create!(password: 'aaabbb', email: 'aaa@example.com')
    user1.reports.create!(id: 1, title: 'title', content: 'mentioned_report desu')
    report2 = user1.reports.create!(title: 'title', content: 'http://localhost:3000/reports/1 osusume')
    assert_equal 1, report2.mentioning_reports.length, report2.mentioning_reports.to_s
  end
end
