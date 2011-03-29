# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first

# Create users
users = User.create!([
  {
    :name => 'Simo Niemelä',
    :password => 'abcabc',
    :email => 'simo.niemela@asd.fi'
  },
  {
    :name => 'Niklas Granö',
    :password => 'abcabc',
    :email => 'niklas.grano@asd.fi'
  },
  {
    :name => 'Olli Salmu',
    :password => 'abcabc',
    :email => 'olli.salmu@asd.fi'
  }
])

# Approve friendships

# Add Niklas as Simo's friend
users[0].add_friend_and_approve!(users[1])

# Add Olli as Simo's friend
users[0].add_friend_and_approve!(users[2])

# Add Niklas as Olli's friend
users[1].add_friend_and_approve!(users[2])

# Add locations
users[0].locations.create!(:latitude => 63.092729, :longtitude => 21.618905)
users[1].locations.create!(:latitude => 63.107864, :longtitude => 21.595323)
users[2].locations.create!(:latitude => 63.109708, :longtitude => 21.596675)
