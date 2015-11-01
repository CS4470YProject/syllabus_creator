class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.integer :number
      t.string :description
      t.timestamps null: false
    end
  end
end
