class Group < ActiveRecord::Base
  validates_presence_of :name, :user_id

end
