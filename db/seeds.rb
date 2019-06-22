# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Entries for role table
Role.find_or_create_by!(name: 'admin')
Role.find_or_create_by!(name: 'developer')

# Entries for user table for admin role
admin_role = Role.find_by_name('admin')
if admin_role.present?
	User.create!(email: 'admin@gmail.com', password: 'password', 
							password_confirmation: 'password',
							role: admin_role)
end