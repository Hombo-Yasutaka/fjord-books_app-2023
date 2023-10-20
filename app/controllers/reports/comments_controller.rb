# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_report, only: %i[create destroy]
  before_action :set_comment, only: %i[create destroy]

  def new
    @comment = current_user.comments.new
  end

  def create
    @comment = @report.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to polymorphic_url(@comment.imageable), notice: 'Comment was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_report
    @report = Report.find(params[:report_id])
  end

  def set_comment
    @comment = @report.comments.new(comment_params)
  end

end