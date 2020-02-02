class CommentsController < ApplicationController

  def new
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.new
    @comment.attributes = comment_params if request.post?
  end

  def confirm
    @topic = Topic.find(params[:topic_id])
    if request.post?
      @comment = @topic.comments.new(comment_params)
      if @comment.valid?
        render :action => 'confirm'
      else
        render :action => 'new'
      end
    else
      @comment = Comment.new
      render :action => 'new'
    end
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
    params.require(:comment).permit(:content, :image, :image_cache, :remove_image).merge(user_id: current_user.id, topic_id:params[:topic_id])
  end
end
