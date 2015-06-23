class AddPostIdToRevision < ActiveRecord::Migration
  def change
    add_column :revisions, :post_id, :integer
  end
end
