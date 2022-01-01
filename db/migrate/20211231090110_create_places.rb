class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :name
      t.text :description
      t.references :place_category, null: false, foreign_key: true
      t.integer :status
      t.string :latlong
      t.string :website
      t.string :contact_number

      t.timestamps
    end
  end
end
