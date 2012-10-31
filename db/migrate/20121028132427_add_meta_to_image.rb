class AddMetaToImage < ActiveRecord::Migration
  def self.up
    add_column :articles, :image_meta,    :text
  end

  def self.down
    remove_column :articles, :image_meta
  end
end