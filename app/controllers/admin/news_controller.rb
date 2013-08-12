class Admin::NewsController < AdminController

  layout 'admin'
  #authentication before filter is in admin controller

  def index
    @news = News.all()
  end

  def new
    @news = News.new()
    render "admin/news/create_edit"
  end

  def edit
    @news = News.find(params[:id])
    render "admin/news/create_edit"
  end

  def update
    @news = News.find(params[:id])
    if @news.update_attributes params[:news]
      redirect_to admin_news_index_path
    else
      render "admin/news/create_edit"
    end
  end

  def create
    @news = News.new(params[:news])
    if @news.save()
      redirect_to admin_news_index_path
    else
      render "admin/news/create_edit"
    end
  end

end
