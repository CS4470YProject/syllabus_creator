class CreateHeaders < ActiveRecord::Migration
  def change
    create_table :headers do |t|
      t.string :text
      t.boolean :bold
      t.boolean :italic
      t.boolean :underline
      t.integer :size
      t.references :element
      t.timestamps null: false
    end
  end
end
