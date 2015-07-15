class Api::V1::UsersController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_api_user!, only: [:show, :update]

  def show
  end

  def update

    unless @resource.update(user_params)
      @model = @resource
      render :template=>"/api/shared/errors.json.jbuilder", :status=> :unprocessable_entity
    end

  end

  private

    def user_params
      params.require(:user).permit(:name)
    end

end
