class User < ActiveRecord::Base
  #Yes, it's true this should be named team

  has_many :groups
  validates_presence_of :username, :display_name
  validates :username, format: { without: /\s/ }, uniqueness: true

  # Other devise modules: :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def to_param
    username
  end
end
