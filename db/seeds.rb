# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin_role = Role.create(role_type: 'admin')
instructor_role = Role.create(role_type: 'instructor')
instructor = User.new(first_name: 'instructor', last_name: 'user', email: 'instructor@example.com', password: 'password')
admin = User.new(first_name: 'admin', last_name: 'user', email: 'admin@example.com', password: 'password')
instructor.roles << instructor_role
admin.roles << admin_role
instructor.save
admin.save

cs4470 = Course.create(code: 'cs4470')
cs3333 = Course.create(code: 'cs3333')
cs3319 = Course.create(code: 'cs3319')

Outline.create(course: cs4470, user: instructor)
Outline.create(course: cs3333, user: admin)
