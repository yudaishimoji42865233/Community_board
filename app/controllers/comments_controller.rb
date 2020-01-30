class CommentsController < ApplicationController

  def new
    @topic = Topic.find(params[:topic_id])
    @comment = Comment.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.create!(comment_params)
    @topic.touch
    @topic.updated_at
    redirect_to topic_path(params[:topic_id]), method: :get
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :image).merge(user_id: current_user.id)
  end
end
