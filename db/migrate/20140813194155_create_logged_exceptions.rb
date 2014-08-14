class CreateLoggedExceptions < ActiveRecord::Migration
  def change
    return if table_exists? :logged_exceptions    
    create_table :logged_exceptions, :force => true do |t|
      t.string :exception_class
      t.string :controller_name
      t.string :action_name
      t.text :message
      t.text :backtrace
      t.text :environment
      t.text :request
      t.datetime :created_at
    end
  end
end
