class NewsController < ApplicationController

  layout 'app'

  def show
    @wrapper = "marketing"
    @news = News.find(params[:id])
  end

end
