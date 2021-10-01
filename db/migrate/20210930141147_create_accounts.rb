class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.references :bank, null: false, foreign_key: true
      t.string :account_name
      t.string :account_number
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
