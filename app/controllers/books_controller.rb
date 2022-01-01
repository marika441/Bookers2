class BooksController < ApplicationController

  def index
    @user = current_user
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorites).
      sort {|a,b|
        b.favorites.includes(:favorites).where(created_at: from...to).size <=>
        a.favorites.includes(:favorites).where(created_at: from...to).size
      }
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = User.find(current_user.id)
    totalExp = @user.experience_point
    totalExp += @book.point.to_i
    @user.experience_point = totalExp
    @user.update(experience_point: totalExp)
    levelSetting = LevelSetting.find_by(level: @user.level + 1);
      if levelSetting.thresold <= @user.experience_point
        @user.level = @user.level + 1
        @user.update(level: @user.level)
      end
      if @book.save
         flash[:notice]="You have creatad book successfully."
         redirect_to book_path(@book.id)
      else
         @user = current_user
         @books = Book.all
         render :index
      end
  end

  def show
    @book = Book.find(params[:id])
    impressionist(@book, nil, unique: [:ip_address])
    @book_comment = BookComment.new
    @user = @book.user
    @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
        render :edit
    else
        redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
        flash[:notice]="Book was successfully updated."
        redirect_to book_path(@book.id)
    else
        render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :point, :experience_point, :user_id, :start_time)
  end
end
