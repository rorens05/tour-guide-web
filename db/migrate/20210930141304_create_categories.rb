class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :transaction_type

      t.timestamps
    end
  end
end
