class AddIsWipToPost < ActiveRecord::Migration
  def change
    add_column :posts, :is_wip, :boolean
  end
end
