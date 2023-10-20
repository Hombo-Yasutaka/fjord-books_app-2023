# frozen_string_literal: true

class Base::CommentsController < ApplicationController

  def destroy
    @comment.destroy

    redirect_to polymorphic_url(@comment.imageable), notice: 'Comment was successfully deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :owner)
  end

end
