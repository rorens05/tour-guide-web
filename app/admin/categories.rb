ActiveAdmin.register Category do
  permit_params :name, :description, :transaction_type
end
