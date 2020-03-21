# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_user = User.new
admin_user.email = 'admin@gmail.com'
admin_user.password = 'Password1'
admin_user.password_confirmation =
admin_user.admin = true
admin_user.save!
