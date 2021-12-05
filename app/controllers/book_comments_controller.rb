class BookCommentsController < ApplicationController
  def create
    @book = Book.find_by(id: params[:book_id])
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
  end

  def destroy
    @book = Book.find_by(id: params[:book_id])
    @comment = Book.find_by(id: params[:book_id])
    BookComment.find_by(id: params[:id]).destroy
  end
  
  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
