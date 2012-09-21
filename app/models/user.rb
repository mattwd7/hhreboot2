class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :forem_admin
  attr_accessible :building_id, :contact, :major, :major2, :minor, :minor2
  attr_accessible :about_me, :year, :new_messages, :confirmed_at, :avatar_path
  
  has_many :posts, :class_name => "Forem::Post"
  has_many :topics, :class_name => "Forem::Topic"
  has_many :quarters
  has_many :courses, :through => :quarters
  has_many :messages
  belongs_to :building
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :textbooks
  
  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true

  def to_s
    username
  end

  after_create :default_quarter
  def default_quarter
    Quarter.create(:user_id => self.id, :term => "Fall 2012")
  end

  after_create :default_building
  def default_building
    self.update_attributes(:building_id => Building.where(:name => "Residence Unknown").first.id)
  end

  def custom_avatar_url
    if self.avatar_path
        avatar_path
    else
      "/superbear_avatar.png"  #default Avatar
    end
  end

end
