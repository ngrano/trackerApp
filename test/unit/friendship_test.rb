# encoding: utf-8

require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @simo = Factory.create(:user)
    @niklas = Factory.create(:user, :first_name => 'Niklas', :last_name => 'Granö')
  end

  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "users are not friends by default" do
    assert !@simo.friends.include?(@niklas)
  end

  test "approved is false after a friend request" do
    @simo.friends << @niklas
    assert !@simo.friendships.first.approved.nil?
    assert !@simo.friendships.first.approved?
    assert @simo.friends.empty?
    assert @simo.pending_friends.size == 1
    assert @simo.pending_friends.include?(@niklas)

    assert @niklas.friends.empty?
    assert @niklas.friend_requests.include?(@simo), "Niklas has no pending friends"
  end

  test "confirm a friendship" do
    assert @simo.friends.empty?
    @simo.friends << @niklas
    assert @simo.friends.empty?
    assert @niklas.friendship_requests.size == 1

    @niklas.friendship_requests.first.approve!

    assert @simo.friends.include?(@niklas), "Niklas is not simos friend"
  end
end
