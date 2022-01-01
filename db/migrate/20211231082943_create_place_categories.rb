class CreatePlaceCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :place_categories do |t|
      t.string :name
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
