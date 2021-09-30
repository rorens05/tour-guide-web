ActiveAdmin.register City do
  menu parent: ['Settings','Addresses']
  permit_params :code, :name, :province_id
end
