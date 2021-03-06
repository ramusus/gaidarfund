class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :position
      t.string :color
      t.string :background_color
      t.text :content
      t.string :link
      t.boolean :hide
      t.string :title

      t.timestamps
    end
  end
end
