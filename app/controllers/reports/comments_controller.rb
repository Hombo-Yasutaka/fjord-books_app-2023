# frozen_string_literal: true

class Reports::CommentsController < Base::CommentsController
  before_action :set_report, only: %i[new create]

  def new
    @comment = @report.comments.new
  end

  def create
    @comment = @report.comments.new(comment_params)
    @comment.owner = current_user.id

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
end
