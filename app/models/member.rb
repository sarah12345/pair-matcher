class Member < ActiveRecord::Base
  belongs_to :group
  belongs_to :team

  validates_presence_of :first_name, :last_name
  default_scope { order('first_name ASC, last_name ASC') }

  def name
    "#{first_name} #{last_name}"
  end
end
