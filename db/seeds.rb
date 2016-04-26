# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

admin_role = Role.create(role_type: 'admin')
instructor_role = Role.create(role_type: 'instructor')
instructor = User.new(first_name: 'instructor', last_name: 'user', email: 'instructor@example.com', password: 'password')
admin = User.new(first_name: 'admin', last_name: 'user', email: 'admin@example.com', password: 'password')
instructor.roles << instructor_role
admin.roles << admin_role
instructor.save
admin.save

faculty_western = Faculty.create(name: 'western')
faculty_science = Faculty.create(name: 'science', parent: faculty_western)

category_cs = Category.create(name: 'Computer-Science', faculty: faculty_science)

template_cs = Template.create(category: category_cs)

immutable = Rule.create(immutable: true)
required = Rule.create(required: true)

element_immutable = Element.create(text: "This is an immutable element: #{Faker::Lorem.paragraph(6)}", rank: 0)
element_immutable.rules << immutable
element_immutable.create_header(text: 'This is an immutable element', size: 24, bold: true)
element_required = Element.create(text: "This is a required element: #{Faker::Lorem.paragraph(6)}", rank: 1)
element_required.rules << required
element_required.create_header(text: 'This is a required element', size: 24, underline: true)
element_required_immutable = Element.create(text: "This is an immutable required element: #{Faker::Lorem.paragraph(6)}", rank: 0)
element_required_immutable.rules << immutable << required
element_required_immutable.create_header(text: 'This is an immutable required element', size: 24, italic: true)

group_1 = ElementGroup.create(rank: 0, outline: template_cs)
group_1.elements << element_immutable
group_1.elements << element_required
group_1.create_header(text: 'Group Header', size: 30, bold: true, underline: true)
group_2 = ElementGroup.create(rank: 1, outline: template_cs)
group_2.elements << element_required_immutable
group_2.create_header(text: 'Group 2 Header', size: 30, bold: true, underline: true)
# e_i_oe = OutlineElement.create(outline: template_cs, element: element_immutable, order: 1)
# e_r_oe = OutlineElement.create(outline: template_cs, element: element_required, order: 2)
# e_ri_oe = OutlineElement.create(outline: template_cs, element: element_required_immutable, order: 3)

#template_cs.outline_elements << e_i_oe << e_r_oe << e_ri_oe
template_cs.element_groups

Tool.insert('test tool', element_immutable.id, faculty_science.id)

tool = Tool.create(faculty: faculty_western, element: element_immutable, name: "This is a tool")
faculty_western.tools << tool
element_immutable.tools << tool



Rake::Task['db:seed_senate_rules'].invoke

# cs4470 = Course.create(code: 'cs4470')
# cs3333 = Course.create(code: 'cs3333')
# cs3319 = Course.create(code: 'cs3319')
#
# Outline.create(course: cs4470, user: instructor)
# Outline.create(course: cs3333, user: admin)
