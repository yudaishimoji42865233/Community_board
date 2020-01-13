class CategoriesController < ApplicationController

  def show
    @topic = Topic.where(category_id: params[:id])
  end
end
