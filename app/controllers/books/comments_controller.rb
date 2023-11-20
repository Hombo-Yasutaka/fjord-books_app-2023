# frozen_string_literal: true

class Books::CommentsController < Base::CommentsController
  before_action :set_book, only: %i[new create]

  def new
    @comment = @book.comments.new
  end

  def create
    @comment = @book.comments.new(comment_params)
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

  def set_book
    @book = Book.find(params[:book_id])
  end
end
