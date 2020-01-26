class TopicsController < ApplicationController

  def index
    if params[:q].present?
      @q = Topic.search(params[:q])
      @topic = @q.result(distinct: true)
    else
      params[:q] = { sorts: 'id desc' }
      @q = Topic.search()
      @topic = @q.result(distinct: true)
    end
  end

  # def search
  #   @q = Topic.search(params[:q])
  #   @topic = 
  #     if params[:q].present?
  #       Topic.none
  #     else
  #       @q.result(distinct: true)
  #     end
  #   render action: :index
  # end

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
    @comment = Comment.where(topic_id: params[:id])
    @enquete = Enquete.where(topic_id: params[:id])
    @topic_like = TopicLike.where(topic_id: params[:id])
    @user_topic_like = @topic_like.find_by(user_id: current_user.id) if user_signed_in?
    comment_likes = CommentLike.where(comment_id: @comment.ids)
    if comment_likes.present?
      comment_likes.each do |comment_like|
        products = comment_likes.where(comment_id: comment_like.comment_id)
        user_products = products.find_by(user_id: current_user.id) if user_signed_in?
        instance_variable_set("@user_comment_like#{user_products.comment_id}", user_products) if user_products.present?
        instance_variable_set("@comment_like#{comment_like.comment_id}", products.length)
      end
    end
    @total_vote = Vote.where(enquete_id: @enquete.ids)
    @user_vote = @total_vote.find_by(user_id: current_user.id) if user_signed_in?
  end

  # def index_sort
  #   case params[:id].to_i
  #     when 1 then
  #       # @topic = Topic.order('whatch DESC')
  #       redirect_to root_path
  #     when 2 then
  #       # @topic = Topic.order('like DESC')
  #       redirect_to root_path
  #     when 3 then
  #       @topic = Topic.order('created_at DESC')
  #       render action: :index
  #     when 4 then
  #       @topic = Topic.order('updated_at DESC')
  #       render action: :index
  #     when 5 then
  #       # @topic = Topic.where(user_id: current_user.id)
  #       redirect_to root_path
  #     else
  #       redirect_to root_path
  #   end
  # end

  # def index_category
  #   @topic = Topic.where(category_id: params[:id])
  #   render action: :index
  # end

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

  def vote
    Vote.create!(vote_params)
    @enquete = Enquete.where(topic_id: params[:id])
    @total_vote = Vote.where(enquete_id: @enquete.ids)
  end

  def topic_like
    TopicLike.create!(topic_like_params)
    @topic_like = TopicLike.where(topic_id: params[:topic_id])
  end

  def topic_like_destroy
    TopicLike.find_by(topic_id: params[:topic_id], user_id: current_user.id).delete
    @topic_like = TopicLike.where(topic_id: params[:topic_id])
  end

  def comment_like
    CommentLike.create!(comment_like_params)
    @comment_like = CommentLike.where(comment_id: params[:comment_id])
  end

  def comment_like_destroy
    CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id).delete
    @comment_like = CommentLike.where(comment_id: params[:comment_id])
  end

  private

  def topic_params
    params.require(:topic).permit(:username, :title, :content, :image, :category_id, enquetes_attributes: [:id, :content, :topic_id]).merge(user_id: current_user.id)
  end

  def vote_params
    params.permit(:enquete_id).merge(user_id: current_user.id)
  end

  def topic_like_params
    params.permit(:topic_id).merge(user_id: current_user.id)
  end

  def comment_like_params
    params.permit(:comment_id).merge(user_id: current_user.id)
  end

  def search_params
    params.require(:q).permit!
  end
end
