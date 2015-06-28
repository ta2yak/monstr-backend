require 'rails_helper'

RSpec.describe "Indexes", type: :request do
  describe "Public API" do

  end

  describe "Require Token API" do

    before do
      @user = FactoryGirl.create(:user)
      @user.save!

      @post1 = FactoryGirl.create(:post_with_index1)
      @post2 = FactoryGirl.create(:post_with_index2)

      @auth_headers = @user.create_new_auth_token

    end

    describe "GET /api/v1/index/all" do

      it "returns not authrized" do
        get api_v1_index_all_path
        expect(response).to have_http_status(401)
      end

      it "returns http success" do
        get api_v1_index_all_path, { }, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it "returns status" do
        get api_v1_index_all_path, { }, @auth_headers
        expect(response.body).to have_json_path('status')
      end

      it "returns indexes" do
        get api_v1_index_all_path, { }, @auth_headers
        expect(response.body).to have_json_path('indexes')
      end

    end

  end

end
