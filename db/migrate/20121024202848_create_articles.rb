class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :subtitle
      t.attachment :image
      t.boolean :main
      t.boolean :hide
      t.boolean :hide_discussions
      t.boolean :checked
      t.integer :old_id
      t.datetime :published_at
      t.string :title_seo
      t.text :right_column
      t.integer :project_id
      t.integer :type

      t.timestamps
    end
  end
end
