class BooksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was created successfully"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all.sort {|a,b| b.favorited_users.count <=> a.favorited_users.count}
    @user = current_user
  end

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = User.find(@books.user.id)
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user.id == current_user.id
    else
      redirect_to books_path
    end
  end

  def update
     @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was updated successfully"
      redirect_to book_path(@book)
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
    params.require(:book).permit(:title, :body)
  end
end
