class Api::V1::IndexController < ApplicationController
  before_action :authenticate_api_user!

  def all

    # こんな感じのjsonを作る
    # [
    #   {id:"123", type:"node", title:"title", nodes: {
    #     id:"234", type:"node", title:"body", nodes: {
    #       id:"345", type:"item", title:"aaaa", post: "200"
    #     }
    #   }
    # ]
    #
    render json: {status: :success, indexes: generate_index(Index.roots)}
  end

private
  def generate_leaf(node)
    {type: "item", title: node.name}
  end

private
  def generate_index(nodes)
    indexes = []
    nodes.each do |node|
      indexes << {id: node.id, type: "item", title: node.name, post: node.post.id} if node.leaf?
      indexes << {id: node.id, type: "node", title: node.name, nodes: generate_index(node.children)} unless node.leaf?
    end
    indexes
  end

end
