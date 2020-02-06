class VotesController < ApplicationController
  
  def create
    @enquete = Enquete.where(topic_id: params[:topic_id])
    @total_vote = Vote.where(enquete_id: @enquete.ids)
    unless @total_vote.find_by(user_id: current_user.id)
      Vote.create!(vote_params)
      @total_vote = Vote.where(enquete_id: @enquete.ids)
    end
    @user_vote = @total_vote.find_by(user_id: current_user.id)
  end

  private

  def vote_params
    params.permit(:enquete_id).merge(user_id: current_user.id)
  end
end