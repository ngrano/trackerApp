class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  before_create :set_approved_to_false

  def set_approved_to_false
    write_attribute(:approved, 'f')
  end

  def approve!
    update_attribute(:approved, 't')
  end
end
