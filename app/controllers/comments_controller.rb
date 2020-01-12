class CommentsController < ApplicationController

  def index
    @topic = Topic.find(params[:topic_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.create!(comment_params)
    redirect_to topic_path(params[:topic_id]), method: :get
  end


  private

  def comment_params
    params.require(:comment).permit(:username, :content, :image).merge(topic_id: params[:topic_id])
  end
end
