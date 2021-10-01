class AddNameToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :name, :string, after: :id
  end
end
