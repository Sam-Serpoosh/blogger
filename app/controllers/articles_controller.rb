class ArticlesController < ApplicationController
  before_filter :require_login, except: [:index, :show, 
                                         :populars, :published_in, 
                                         :feed
                                        ]
  
                                        
  def feed
    @feed_title = "Articles Feed"
    @articles = Article.order("updated_at desc")
    @feed_updated = @articles.first.updated_at unless @articles.empty?

    respond_to do |format|
      format.atom {
        render :content_type => 'application/atom+xml'
      }
    end
  end

	def index
		@articles = Article.all
	end

  def populars
    @articles = Article.popular_articles
    render action: "index"
  end

  def published_in
    @selected_month = params[:month]
    @articles = ArticlesMonthNavigator.articles_in @selected_month
    render action: "index"
  end

  def show
    @article = Article.find(params[:id])
		@article.viewed
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash.notice = "Article #{@article.title} Created!"
      redirect_to article_path(@article)
    else
      render action: "new"
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(params[:article])
      flash.notice = "Article #{@article.title} Updated!"
      redirect_to article_path(@article)
    else
      render action: "edit"
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash.notice = "Article #{@article.title} Deleted!"

    redirect_to articles_path
  end
end
