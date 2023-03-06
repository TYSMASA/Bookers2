class BooksController < ApplicationController
 before_action :is_matching_login_user, only: [:edit, :update]
 def new
  @book = Book.new   
 end 
 
 # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if@book.save
    flash[:notice] = "You have updated user successfully" 
    redirect_to book_path(@book.id)
    else
      @books =Book.all     
      render :index
    end
  end
  
  def index
   @book = Book.new
   @books = Book.all
  end
  
  def show
   @book=Book.find(params[:id])  
  end

  def destroy
   book =Book.find(params[:id])
   book.destroy
   redirect_to '/books'
  end
  
  def edit
   @book =Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = 'Book was successfully updated.'
      redirect_to book_path(@book.id)  
    else
      render :edit
    end
  end
 
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    @book = Book.find(params[:id])
    user_id = @book.user_id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end
end
