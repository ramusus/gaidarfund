class CreateEvents < ActiveRecord::Migration
  def change
  	return if table_exists? :events
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.text :content

      t.timestamps
    end
  end
end
