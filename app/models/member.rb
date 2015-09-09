class Member < ActiveRecord::Base
  belongs_to :group
  belongs_to :team

  validates_presence_of :first_name, :last_name

  def name
    "#{first_name} #{last_name}"
  end
end
