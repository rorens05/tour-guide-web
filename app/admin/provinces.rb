ActiveAdmin.register Province do
  menu parent: ['Settings','Addresses']
  permit_params :region_id, :name, :code
end
