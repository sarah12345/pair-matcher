class User < ActiveRecord::Base

  validates_presence_of :username, :display_name
  validates :username, format: { without: /\s/ }

  # Other devise modules: :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

end
