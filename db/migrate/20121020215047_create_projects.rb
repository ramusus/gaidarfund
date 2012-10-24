class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :title_short
      t.string :color
      t.string :sign
      t.text :description
      t.text :description_short

      t.integer :status
      t.text :html_likes
      t.text :html_partners
      t.text :html_counters


      t.string   :background_image_file_name
      t.string   :background_image_content_type
      t.integer  :background_image_file_size
      t.datetime :background_image_updated_at

      t.string   :logo_image_file_name
      t.string   :logo_image_content_type
      t.integer  :logo_image_file_size
      t.datetime :logo_image_updated_at

      t.timestamps
    end
  end
end
