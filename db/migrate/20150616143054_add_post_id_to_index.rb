class AddPostIdToIndex < ActiveRecord::Migration
  def change
    add_column :indices, :post_id, :integer
  end
end
