class AddPlaceToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :place_id, :integer
  end
end
