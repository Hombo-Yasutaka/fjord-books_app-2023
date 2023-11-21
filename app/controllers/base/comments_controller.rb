# frozen_string_literal: true

class Base::CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]

  def destroy
    @comment.destroy

    redirect_to polymorphic_url(@comment.imageable), notice: 'Comment was successfully deleted'
  end

  private

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
