class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :image, ImageUploader
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_uniqueness_of :nickname       
  has_many :blogs
  has_many :comments
  belongs_to :agreec
  belongs_to :agree
  belongs_to :follower
  belongs_to :following
  
  def all_delete
    blogs.each{|b| b.destroy}
    comments.each{|b| b.destroy}
  end
end
