require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "Public API" do
    describe "GET /api/v1/posts" do

      it "returns http success" do
        get api_v1_posts_path
        expect(response).to have_http_status(:success)
      end

    end

    describe "GET /api/v1/posts/search" do

      it "returns http success" do
        get api_v1_posts_search_path
        expect(response).to have_http_status(:success)
      end

    end

  end

  describe "Require Token API" do

    before do
      @user = FactoryGirl.create(:user)
      @user.save!

      @auth_headers = @user.create_new_auth_token

    end

    describe "POST /api/v1/posts" do

      it "returns not authrized" do
        post api_v1_posts_path, { post: FactoryGirl.attributes_for(:post) }
        expect(response).to have_http_status(401)
      end

      it "returns http success" do
        post api_v1_posts_path, { post: FactoryGirl.attributes_for(:post) }, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it "returns status" do
        post api_v1_posts_path, { post: FactoryGirl.attributes_for(:post) }, @auth_headers
        expect(response.body).to have_json_path('status')
      end

    end

  end

end
