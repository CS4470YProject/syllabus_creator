class CreateSenateRules < ActiveRecord::Migration
  def change
    create_table :senate_rules do |t|
      t.references :faculty
      t.references :element
      t.string :name
      t.string :description
      t.timestamps null: false
    end
  end
end
