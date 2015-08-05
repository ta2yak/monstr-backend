require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "Public API" do
  end

  describe "Require Token API" do

    before do
      @user = FactoryGirl.create(:user)
      @user.save!

      @auth_headers = @user.create_new_auth_token

    end

    describe "USER GET /api/v1/me" do

      it "returns not authrized" do
        get api_v1_me_path
        expect(response).to have_http_status(401)
      end

      it "returns http success" do
        get api_v1_me_path, { }, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it "returns status" do
        get api_v1_me_path, { }, @auth_headers
        expect(response.body).to have_json_path('status')
      end

      it "returns user" do
        get api_v1_me_path, { }, @auth_headers
        expect(response.body).to have_json_path('user')
      end

    end

    describe "USER PUT /api/v1/me" do

      it "returns not authrized" do
        put api_v1_me_path
        expect(response).to have_http_status(401)
      end

      it "returns http success" do
        put api_v1_me_path, { user: { name: "Hello" } }, @auth_headers
        expect(response).to have_http_status(:success)
      end

      it "returns status" do
        put api_v1_me_path, { user: { name: "Hello" } }, @auth_headers
        expect(response.body).to have_json_path('status')
      end

      it "returns user" do
        put api_v1_me_path, { user: { name: "Hello" } }, @auth_headers
        expect(response.body).to have_json_path('user')
      end

    end

  end

end
