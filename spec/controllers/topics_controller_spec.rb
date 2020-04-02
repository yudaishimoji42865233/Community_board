require 'rails_helper'

describe TopicsController do
  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested topic to @topic" do
      topic = create(:topic)
      get :edit, params: { id: topic }
      expect(assigns(:topic)).to eq topic
    end

    it "renders the :edit template" do
      topic = create(:topic)
      get :edit, params: { id: topic }
      expect(response).to render_template :edit
    end
  end

  describe 'GET #index' do
    it "populates an array of topics ordered by created_at DESC" do
      topics = create_list(:topic, 3)
      get :index
      expect(assigns(:topic)).to match(topics.sort{ |a, b| b.created_at <=> a.created_at } )
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index 
    end
  end
end