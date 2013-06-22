class ProductsController < ApplicationController

  layout 'app'

  def show
    @wrapper = "detail"
    @product = Product.find(params[:id])
  end

  def comment
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.save
    redirect_to show_collection_path(@comment.product_id)
  end

  def comment_helpful
    ch = CommentHelp.new({ comment_id: params[:comment_id],
                           user_id: current_user.id,
                           helpful: (params[:flag] == 'true' ? true : false)
                        })
    status = ch.save
    if status
      render json: { message: "Saved"}
    else
      render json: { message: "Already marked by you"}
    end
  end

end
