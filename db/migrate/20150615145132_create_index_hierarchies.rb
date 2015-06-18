class CreateIndexHierarchies < ActiveRecord::Migration
  def change
    create_table :index_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :index_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "index_anc_desc_idx"

    add_index :index_hierarchies, [:descendant_id],
      name: "index_desc_idx"
  end
end
