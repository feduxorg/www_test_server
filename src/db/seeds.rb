# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
%w(user admin guest).each do |role|
  Role.find_or_create_by(name: role)
end

User.create email: 'admin@example.org', password: '*Test123', role: Role.where(name: 'admin').first, approved: true
User.create email: 'anonymous', password: '*Test123', role: Role.where(name: 'guest').first, approved: false
