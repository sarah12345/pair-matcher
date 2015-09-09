class Group < ActiveRecord::Base

  belongs_to :team
  has_many :members
  validates_presence_of :name, :team_id

end
