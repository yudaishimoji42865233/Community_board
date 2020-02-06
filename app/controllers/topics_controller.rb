class TopicsController < ApplicationController

  def index
    if params[:q].present?
      @q = Topic.search(search_params)
      @q.sorts = 'created_at desc' if @q.sorts.empty?
      params[:page] ||= 1
      @topic = @q.result(distinct: true).page(params[:page]).per(20)
    else
      params[:q] = { sorts: 'created_at desc' }
      @q = Topic.ransack(params[:q])
      params[:page] ||= 1
      @topic = @q.result(distinct: true).page(params[:page]).per(20)
    end
  end

  def new
    @topic = Topic.new
    @topic.attributes = topic_params if request.post?
    @enquete = @topic.enquetes.build
  end

  def confirm
    if request.post?
      @topic = Topic.new(topic_params)
    else
      @topic = Topic.find(params[:id])
      @topic.attributes = topic_params if request.patch?
    end
    if @topic.valid?
      @enquete = @topic.enquetes.build
      render :action => 'confirm'
    else
      @enquete = @topic.enquetes.build
      render :action => request.post? ? 'new' : 'edit'
    end
  end

  def create
    @topic = Topic.new(topic_params)
    render :confirm if @topic.invalid?
    @topic = Topic.create(topic_params)
    if params[:enquetes].present?
      params[:enquetes]['content'].each do |i|
        if i.present?
          @enquete = @topic.enquetes.create!(content: i, topic_id: @topic.id)
        end
      end
    end
    redirect_to root_path
  end

  def show
    if (params[:id] =~ /\A[0-9]+\z/)
      @topic = Topic.find(params[:id])
      impressionist(@topic, nil, :unique => [:session_hash])
      @comment = Comment.page(params[:page]).where(topic_id: params[:id]).per(50).order('created_at ASC')
      @enquete = Enquete.where(topic_id: params[:id])
      @total_vote = Vote.where(enquete_id: @enquete.ids)
      @user_vote = @total_vote.find_by(user_id: current_user.id) if user_signed_in?
      @topic_like = TopicLike.where(topic_id: params[:id])
      @user_topic_like = @topic_like.find_by(user_id: current_user.id) if user_signed_in?
      comment_likes = CommentLike.where(comment_id: @comment.ids)
      if comment_likes.present?
        comment_likes.each do |comment_like|
          products = comment_likes.where(comment_id: comment_like.comment_id)
          user_products = products.find_by(user_id: current_user.id) if user_signed_in?
          instance_variable_set("@user_comment_like_#{user_products.comment_id}", user_products) if user_products.present?
          instance_variable_set("@comment_like_#{comment_like.comment_id}", products.length)
        end
      end
    else
      redirect_to root_path 
    end
  end

  def delete_select
    @topic = Topic.where(user_id: current_user.id).order('created_at ASC')
    @select_topics = Topic.new
  end

  def delete_confirm
    if params[:topic].present?
      @select_topics = Topic.where(delete_params).order('created_at ASC')
      @confirm_topics = Topic.new
    else
      redirect_to delete_select_topics_path
    end
  end

  def delete
    if params[:topic].present?
      @confirm_topics = Topic.where(delete_params)
      @impression = Impression.where(impressionable_id: @confirm_topics.ids).delete_all
      @topic_like = TopicLike.where(topic_id: @confirm_topics.ids).delete_all
      @comment = Comment.where(topic_id: @confirm_topics.ids)
      @comment_like = CommentLike.where(comment_id: @comment.ids).delete_all
      @enquete = Enquete.where(topic_id: @confirm_topics.ids)
      @vote = Vote.where(enquete_id: @enquete.ids).delete_all
      @enquete.delete_all
      @comment.delete_all
      @confirm_topics.delete_all
      redirect_to root_path
    else
      redirect_to delete_select_topics_path
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    @topic.image.cache! unless @topic.image.blank?
    @topic.attributes = topic_params if request.patch?
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update(topic_params)
    redirect_to delete_select_topics_path
  end

  def like
    TopicLike.create!(topic_like_params)
    @topic_like = TopicLike.where(topic_id: params[:topic_id])
  end

  def like_delete
    TopicLike.find_by(topic_id: params[:topic_id], user_id: current_user.id).delete
    @topic_like = TopicLike.where(topic_id: params[:topic_id])
  end

  def comment_like
    CommentLike.create!(comment_like_params)
    @comment_like = CommentLike.where(comment_id: params[:comment_id])
  end

  def comment_like_delete
    CommentLike.find_by(comment_id: params[:comment_id], user_id: current_user.id).delete
    @comment_like = CommentLike.where(comment_id: params[:comment_id])
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :content, :image, :image_cache, :remove_image, :category_id, enquetes_attributes: [:id, :content, :topic_id]).merge(user_id: current_user.id)
  end

  def topic_like_params
    params.permit(:topic_id).merge(user_id: current_user.id)
  end

  def comment_like_params
    params.permit(:comment_id).merge(user_id: current_user.id)
  end

  def search_params
    params.require(:q).permit!
    # (:category_id_eq_any, :user_id_eq_any, :sorts, :title_cont)
  end

  def delete_params
    params.require(:topic).permit(id:[])
  end
end
