ActiveAdmin.register Category do
  permit_params :name, :description, :transaction_type

  form do |f|  
    f.semantic_errors *f.object.errors.keys
    f.input :image, as: :file
    f.input :name
    f.input :description, input_html: {rows: 2}
    f.input :transaction_type, include_blank: false
    f.actions
  end

  
  index do
    selectable_column
    id_column
    column :name

    column :transaction_type do |category|
      status_tag category.transaction_type
    end
    
    actions
  end 

end
