class Member < ActiveRecord::Base
  belongs_to :group
  belongs_to :team

  validates_presence_of :first_name
  validates_presence_of :last_name, allow_blank: true, allow_nil: false
  validates_uniqueness_of :first_name, scope: [:last_name, :team_id], case_sensitive: false
  default_scope { order('first_name ASC, last_name ASC') }

  def name
    "#{first_name} #{last_name}"
  end

end
