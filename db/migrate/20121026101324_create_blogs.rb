class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :author
      t.attachment :photo
      t.string :link
      t.text :description

      t.timestamps
    end
  end
end
