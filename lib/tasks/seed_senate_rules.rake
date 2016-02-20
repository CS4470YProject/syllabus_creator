require 'faker'
#TODO Update this with real rules etc...
namespace :db do
  task :seed_senate_rules => :environment do
    rules = {
        turnitin: 'western',
        ssc_funding: 'science',
        clickers: 'western',
        graded_labs: 'western',
        equipment_handling: 'science'
    }
    rule_questions = {
        turnitin: 'Does this course use an anti-plagiarism tool such as turnitin?',
        ssc_funding: 'Does this course receive funding from the Science Student Council(SSC)?',
        clickers: 'Does this course use clickers?',
        graded_labs: 'Does this course have graded labs/tutorials?',
        equipment_handling: 'Will students in this course be handling equipment?'
    }
    elements_text = {
        turnitin: "Turnit in policy: #{Faker::Lorem.paragraph(6)}",
        ssc_funding: "SSC Funding details: #{Faker::Lorem.paragraph(6)}",
        clickers: "Clicker Policy: #{Faker::Lorem.paragraph(6)}",
        graded_labs: "Graded Lab Policy: #{Faker::Lorem.paragraph(6)}",
        equipment_handling: "Equipment Handling Policy: #{Faker::Lorem.paragraph(6)}"
    }
    elements_rules = {
        turnitin: %w(required immutable),
        ssc_funding: %w(required immutable),
        clickers: %w(required immutable),
        graded_labs: %w(required),
        equipment_handling: %w(required)
    }

    rules.each do |rule, fac|
      ActiveRecord::Base.transaction do
        faculty = Faculty.where(name: fac).first
        element = Element.create(text: elements_text[rule])
        elements_rules[rule].each do |r|
          element.rules <<  Rule.where(r => true).first
        end
        SenateRule.create(faculty: faculty, name: rule, description: rule_questions[rule], element: element)
      end
    end
  end
end