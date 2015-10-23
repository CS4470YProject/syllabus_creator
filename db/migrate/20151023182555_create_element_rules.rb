class CreateElementRules < ActiveRecord::Migration
  def change
    create_table :element_rules do |t|
      t.references :element, index: true
      t.references :rule, index: true
      t.timestamps null: false
    end
  end
end
