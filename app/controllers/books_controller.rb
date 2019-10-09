class BooksController < ApplicationController
  
  def list
    @books = Book.paginate(page: params[:page]).search(params[:search])
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end


  def create
    @book = Book.new(book_params)
    if @book.save
        flash[:success] = "Success Add New Book"
        redirect_to @book
    else
        render 'new'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    Book.find(params[:id]).destroy
    flash[:success] = "Book deleted"
    redirect_to index_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(book_params)
      flash[:success] = "Book Information Updated"
      redirect_to @book
    else
      render 'edit'
    end
  end

   private

    def book_params
      params.require(:book).permit(:title, :author, :publisher, :genre)
    end
end
