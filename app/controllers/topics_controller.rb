class TopicsController < ApplicationController

  def index
    @topic = Topic.all
  end

  def new
    @topic = Topic.new
    @enquete = @topic.enquetes.build
  end

  def create
    @topic = Topic.create!(topic_params)
    params[:enquetes]['content'].each do |i|
      if i.present?
        @enquete = @topic.enquetes.create!(content: i, topic_id: @topic.id)
      end
    end
    redirect_to root_path
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.where(topic_id: @topic.id)
    @enquete = Enquete.where(topic_id: @topic.id)
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
        render action: :index
      when 4 then
        @topic = Topic.order('updated_at DESC')
        render action: :index
      when 5 then
        # @topic = Topic.where(user_id: current_user.id)
        redirect_to root_path
      else
        redirect_to root_path
    end
  end

  def index_category
    @topic = Topic.where(category_id: params[:id])
    render action: :index
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
    params.require(:topic).permit(:username, :title, :content, :image, :category_id, enquetes_attributes: [:id, :content, :topic_id])
  end

end
