class Api::V1::PostsController < ApplicationController
  before_action :authenticate_api_user!, only: [:create, :update, :destroy]
  before_action :set_post, only: [:update, :destroy]
  before_action :set_post_with_revisions, only: [:show]

  def index
    @posts = Post.all
    render json: {status: :success, posts: @posts}
  end

  def create

    @post = Post.new(post_params)
    @post.user = current_api_user

    if @post.save
      render json: {status: :created, post: @post}
    else
      render json: {errors: {full_messages: @post.errors.full_messages}}, status: :unprocessable_entity
    end

  end

  def show
    render json: {status: :ok, post: @post}
  end

  def update

    if @post.update(post_params)
      render json: {status: :ok, post: @post}
    else
      render json: {errors: {full_messages: @post.errors.full_messages}}, status: :unprocessable_entity
    end

  end

  def destroy
    @post.destroy
    head :no_content
  end

  def search
    @posts = Post.all
    render json: {status: :success, posts: @posts}
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_post_with_revisions
      @post = Post.includes(:revisions).where("posts.id = ?", params[:id]).first
    end

    def post_params
      params.require(:post).permit(:title, :body, :is_wip)
    end

end
