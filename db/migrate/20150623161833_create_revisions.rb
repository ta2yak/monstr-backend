class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.string :headline
      t.text :full_text
      t.text :diff_text
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
