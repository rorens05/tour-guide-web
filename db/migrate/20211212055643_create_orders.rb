class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :delivery_address
      t.string :land_mark
      t.string :contact_number
      t.text :note
      t.integer :payment_method
      t.integer :status

      t.timestamps
    end
  end
end
