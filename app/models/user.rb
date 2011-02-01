class User < ActiveRecord::Base
  has_many :friendships
  has_many :locations

  has_many :pending_friends, :through => :friendships, :source => :friend,
    :conditions => ['friendships.approved = ?', false]

  has_many :friends, :through => :friendships,
    :conditions => ['friendships.approved = ?', true]

  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'

  has_many :inverse_friends, :through => :inverse_friendships, :source => :user,
    :conditions => ['friendships.approved = ?', true]

  has_many :friend_requests, :through => :inverse_friendships, :source => :user,
    :conditions => ['friendships.approved = ?', false]

  has_many :friendship_requests, :class_name => 'Friendship', :foreign_key => 'friend_id',
    :conditions => ['friendships.approved = ?', false]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
