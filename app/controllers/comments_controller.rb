# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]
  before_action :set_id, only: %i[new create]

  def new
    if @report_id.present?
      report = Report.find(@report_id)
      @comment = report.comments.new
    else
      book = Book.find(@book_id)
      @comment = book.comments.new
    end
  end

  def create
    if @report_id.present?
      report = Report.find(@report_id)
      @comment = report.comments.new(comment_params)
    else
      book = Book.find(@book_id)
      @comment = book.comments.new(comment_params)
    end
    @comment.owner = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to polymorphic_url(@comment.imageable), notice: 'Comment was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    redirect_to polymorphic_url(@comment.imageable), notice: 'Comment was successfully deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_id
    @report_id = params[:report_id]
    @book_id = params[:book_id]
  end
end
