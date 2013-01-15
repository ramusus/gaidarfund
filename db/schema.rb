# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130115085427) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "subtitle"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "social_image_file_name"
    t.string   "social_image_content_type"
    t.integer  "social_image_file_size"
    t.datetime "social_image_updated_at"
    t.boolean  "main"
    t.boolean  "main_for_project"
    t.boolean  "hide"
    t.boolean  "hide_discussions"
    t.boolean  "hide_on_index", :default => false
    t.boolean  "checked"
    t.boolean  "only_for_signed", :default => false
    t.boolean  "play_icon", :default => false
    t.integer  "old_id"
    t.datetime "published_at"
    t.string   "title_seo"
    t.text     "right_column"
    t.integer  "project_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "articletype_id"
    t.text     "content"
    t.integer  "old_group_id"
    t.text     "old_descr"
    t.text     "old_descr2"
    t.string   "author",             :default => ""
    t.text     "image_meta"
    t.string   "url",                :default => ""
  end

  create_table "articletypes", :force => true do |t|
    t.string   "name"
    t.string   "name_plural"
    t.string   "slug",                :default => ""
    t.string   "code",                :default => ""
    t.string   "title",                :default => ""
    t.string   "color_class",          :default => ""
    t.integer  "page_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "blogs", :force => true do |t|
    t.string   "author"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "link"
    t.text     "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "chunks", :force => true do |t|
    t.string   "title"
    t.string   "code"
    t.text     "content"
    t.boolean  "visible",    :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "exception_logger_logged_exceptions", :force => true do |t|
    t.string   "exception_class"
    t.string   "controller_name"
    t.string   "action_name"
    t.text     "message"
    t.text     "backtrace"
    t.text     "environment"
    t.text     "request"
    t.datetime "created_at"
  end

  create_table "lecture_subscribers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lecture_subscribers", ["email"], :name => "index_subscribers_email"

  create_table "static_files", :force => true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "file_meta"
    t.string   "alt"
    t.string   "code"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "slug"
    t.boolean  "visible",    :default => true
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "project_id"
    t.integer  "page_id"
    t.integer  "position"
  end

  create_table "projects", :force => true do |t|
    t.string   "title"
    t.string   "color"
    t.string   "sign"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "logo_image_file_name"
    t.string   "logo_image_content_type"
    t.integer  "logo_image_file_size"
    t.datetime "logo_image_updated_at"
    t.text     "status"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.string   "subdomain"
    t.string   "about_title"
    t.string   "news_title"
    t.text     "likes"
    t.text     "counters"
    t.text     "partners"
    t.text     "right_block"
    t.text     "projects"
    t.string   "title_short"
    t.string   "title_list_short",                     :default => ""
    t.text     "html_block"
    t.text     "css_styles"
    t.string   "css_file_name"
    t.string   "css_content_type"
    t.integer  "css_file_size"
    t.datetime "css_updated_at"
    t.string   "logo_small_image_file_name"
    t.string   "logo_small_image_content_type"
    t.integer  "logo_small_image_file_size"
    t.datetime "logo_small_image_updated_at"
    t.text     "logo_small_image_meta"
    t.string   "social_image_file_name"
    t.string   "social_image_content_type"
    t.integer  "social_image_file_size"
    t.datetime "social_image_updated_at"
    t.text     "core",                          :default => ""
    t.string   "title_seo",                     :default => ""
    t.integer  "position"
    t.boolean  "hide",                          :default => false
    t.boolean  "hide_sidebar",                  :default => false
    t.boolean  "hide_news_list",                :default => false
    t.boolean  "not_linkable",                  :default => false
    t.string   "url",                           :default => ""
    t.integer  "per_page",                      :default => 15
    t.string   "archive_periods_title",         :default => ""
    t.integer  "widget_media_articles_count"
    t.integer  "widget_media_position",         :default => 3
  end

  create_table "project_archive_periods", :force => true do |t|
    t.string   "name"
    t.datetime "date_start"
    t.datetime "date_end"
    t.integer  "project_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "project_categories_projects", :force => true do |t|
    t.integer  "project_id"
    t.integer  "project_category_id"
  end

  create_table "project_categories", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "relations", :force => true do |t|
    t.integer  "article_id"
    t.integer  "related_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "slides", :force => true do |t|
    t.integer  "position"
    t.string   "color"
    t.string   "background_color"
    t.text     "content"
    t.string   "link"
    t.boolean  "hide"
    t.string   "title"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "top_text"
    t.string   "background_image_file_name"
    t.string   "background_image_content_type"
    t.integer  "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.string   "color_class",                   :default => ""
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
