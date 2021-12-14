ActiveAdmin.register Order do
  actions :all, except: [:new]

  permit_params :user_id, :delivery_address, :land_mark, :note, :payment_method, :status, :contact_number
  
  index do
    selectable_column
    id_column
    column :user
    column :delivery_address
    column :land_mark
    column :contact_number
    column :payment_method do |item|
      status_tag item.payment_method
    end
    column :status do |item|
      status_tag item.status
    end
    actions
  end

  show do 
    panel "ORDER ##{resource.reference_number}" do
      attributes_table_for resource do
        row :user
        row :delivery_address
        row :land_mark
        row :contact_number
        row :payment_method do 
          status_tag resource.payment_method
        end
        row :status do
          status_tag resource.status
        end
        row :note
      end
    end
    br
    panel "Orders" do
      table_for resource.order_items do
        column :product
        column :quantity
        column :price do |item|
          format_currency item.price
        end
      end
    end
  end

end
