class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.references :faculty, index: true, foreign_key: true
      t.references :element, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
