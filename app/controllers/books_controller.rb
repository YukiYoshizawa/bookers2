class BooksController < ApplicationController
  def new
  end

  def index
    @user = current_user
  end

  def show
  end
end
