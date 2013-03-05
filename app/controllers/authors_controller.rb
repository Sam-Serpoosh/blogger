class AuthorsController < ApplicationController
  before_filter :zero_authors_or_authenticated, only: [:new, :create]
  before_filter :require_login, except: [:new, :create]

  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def edit
    @author = Author.find(params[:id])
  end

  def create
    @author = Author.new(params[:author])

    if @author.save
      redirect_to @author, notice: 'Author was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @author = Author.find(params[:id])

    if @author.update_attributes(params[:author])
      redirect_to @author, notice: 'Author was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    redirect_to authors_url
  end

  private
    def zero_authors_or_authenticated
      unless Author.count == 0 || current_user
        redirect_to root_path
        return false
      end
    end
end
