class TopicsController < ApplicationController

  def index
    @topic = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    Topic.create!(topic_params)
    redirect_to root_path
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.where(topic_id: @topic.id)
  end

  def show2
  end

  def show3
  end

  def new_check
    @topic = Topic.find(1)
    @title = params[:title]
    @content = params[:content]
  end

  def delete_select
  end

  def delete_check
  end

  private

  def topic_params
    params.require(:topic).permit(:username, :title, :content, :image, :category_id)
  end

end
