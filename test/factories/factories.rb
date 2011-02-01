# encoding: UTF-8

require 'active_support/secure_random'

Factory.define :user do |u|
  u.first_name 'Simo'
  u.last_name 'Niemelä'
  u.password 'abcabc'
  u.sequence(:email) { |n| "simo#{n}@asd.fi" }
  u.sequence(:apikey) { |n| SecureRandom.hex(n + 1) }
end