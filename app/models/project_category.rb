class ProjectCategory < ActiveRecord::Base
  default_scope :order => 'position DESC'
  attr_accessible :name, :project_ids, :position
  has_and_belongs_to_many :projects

  def save(args={})
    if not self.position
      self.position = 0
    end
    super(args)
  end

  rails_admin do
    configure :projects do
      inverse_of :project_categories
    end
    list do
      include_fields :name, :position, :projects
    end
    edit do
      include_fields :name, :position, :projects
    end
  end

end