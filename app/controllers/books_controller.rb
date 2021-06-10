class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @book_comment = BookComment.new
  end

  def index
    @book = Book.new
    if params[:sort_created_at]
      @books1 = Book.created_at
    else
      @books = Book.all
    end
    if params[:sort_evaluation]
      @books2 = Book.evaluation
    else
      @books = Book.all
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end
  
  def search
    @range = params[:range]
    search = params[:search]
    keyword = params[:keyword]
    @books = User.search(search, keyword)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :evaluation)
  end

end
