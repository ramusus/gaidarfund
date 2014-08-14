# This migration comes from exception_logger (originally 20120507081835)
class CreateExceptionLoggerLoggedExceptions < ActiveRecord::Migration
  def change
    return if table_exists? :exception_logger_logged_exceptions
    create_table :exception_logger_logged_exceptions, :force => true do |t|
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
