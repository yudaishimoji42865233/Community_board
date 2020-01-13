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

  def index_sort
    case params[:id].to_i
      when 1 then
        # @topic = Topic.order('whatch DESC')
        redirect_to root_path
      when 2 then
        # @topic = Topic.order('like DESC')
        redirect_to root_path
      when 3 then
        @topic = Topic.order('created_at DESC')
      when 4 then
        @topic = Topic.order('updated_at DESC')
      when 5 then
        # @topic = Topic.where(user_id: current_user.id)
        redirect_to root_path
      else
        どの値にも一致しない場合に行う処理
    end
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
