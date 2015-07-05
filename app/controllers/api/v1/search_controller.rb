class Api::V1::SearchController < ApplicationController
  def search
    word = search_params[:word].gsub(/　/, " ").split()
    @posts = Post.search(word)
    render json: {status: :success, posts: @posts}
  end

  private
    def search_params
      params.tapp.require(:search).permit(:word)
    end

end
