class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name

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
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  before_save :generate_api_key

  def add_friend_and_approve!(friend)
    friends << friend
    friendship_request = friend.friendship_requests.last

    raise "Friendship request is nil, could not approve!" if friendship_request.nil?

    friendship_request.approve!
  end

  def self.friends_locations(user)
    scope = Location.select('locations.*, users.first_name, users.last_name')
    scope = scope.joins('inner join users on users.id = locations.user_id')
    scope = scope.joins('inner join friendships on friendships.friend_id = users.id')
    scope = scope.where('friendships.user_id = ?', user.id)
    scope = scope.where('friendships.approved = ?', true)
  end

  def generate_api_key
    if self.email_changed?
      self[:apikey] = Digest::SHA1.hexdigest(self[:email])
    end
  end

  def name=(first_and_last_names)
    parts = first_and_last_names.split(/\s+/)

    if parts && parts.length > 1
      self[:first_name] = parts[0]
      self[:last_name] = parts[1..-1].join(' ')
    end
  end
end
