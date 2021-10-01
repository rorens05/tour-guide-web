ActiveAdmin.register Account do
  permit_params :bank_id, :account_name, :account_number, :name, :user_id
end
