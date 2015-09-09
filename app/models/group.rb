class Group < ActiveRecord::Base

  belongs_to :team
  has_many :members
  validates_presence_of :name, :team_id
  validates_uniqueness_of :name, scope: :team_id, case_sensitive: false

end
