class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_user!, only: [:create, :update, :destroy]
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.all
  end

  def create

    @post = Post.new(post_params)
    @post.user = current_api_user

    unless @post.save
      @model = @post
      render :template=>"/api/shared/errors.json.jbuilder", :status=> :unprocessable_entity
    end

  end

  def show
  end

  def update

    unless @post.update(post_params)
      @model = @post
      render :template=>"/api/shared/errors.json.jbuilder", :status=> :unprocessable_entity
    end

  end

  def destroy
    @post.destroy
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :is_wip)
    end

end
