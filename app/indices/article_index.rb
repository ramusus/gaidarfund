ThinkingSphinx::Index.define :article, :with => :active_record do
#    indexes published_at, :sortable => true
  indexes title
  indexes subtitle
  indexes content
  indexes author

  # attributes
  has project_id, articletype_id, published_at, id
end