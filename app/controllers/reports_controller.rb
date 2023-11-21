# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)

    ActiveRecord::Base.transaction do
      raise ActiveRecord::Rollback unless @report.save

      raise ActiveRecord::Rollback unless (insert_to_mention if exist_mentioned_ids?)

      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    end
    render :new, status: :unprocessable_entity
  end

  def update
    ActiveRecord::Base.transaction do
      raise ActiveRecord::Rollback unless @report.update(report_params)

      @report.mentionings.destroy_all
      raise ActiveRecord::Rollback unless @report.mentionings.all?(&:destroyed?)

      raise ActiveRecord::Rollback unless (insert_to_mention if exist_mentioned_ids?)

      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    end
    render :edit, status: :unprocessable_entity
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def exist_mentioned_ids?
    mentioning_ids = []
    report_params[:content].scan(%r{#{reports_url}/([1-9][0-9]*)}) do |s|
      mentioning_ids << s[0].to_i
    end
    mentioning_ids.uniq!
    @existing_mentioned_ids = Report.where(id: mentioning_ids).pluck(:id)
    @existing_mentioned_ids.present?
  end

  def insert_to_mention
    @existing_mentioned_ids.each do |id|
      Mention.create(mentioning_id: @report.id, mentioned_id: id)
    end
  end
end
