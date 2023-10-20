# frozen_string_literal: true

class CommentsController < Base::CommentsController
  before_action :set_comment, only: %i[create]

  def new
    book = Book.find(params[:book_id])
    @comment = book.comments.new
  end

  def create
    respond_to do |format|
      if @comment.save
        format.html { redirect_to polymorphic_url(@comment.imageable), notice: 'Comment was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_comment
    book = Book.find(params[:book_id])
    @comment = book.comments.new(comment_params)
    @comment.owner = current_user.id
  end
end
