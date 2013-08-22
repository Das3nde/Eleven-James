class NewsController < ApplicationController

  layout 'app'

  def index
    @wrapper = "marketing"
    @news = News.published.order("date DESC")
    @latest_news = News.published.order("date DESC").limit(2)
  end

  def show
    @wrapper = "marketing"
    @news = News.find(params[:id])
  end

end
