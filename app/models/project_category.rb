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

end