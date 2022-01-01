ActiveAdmin.register Product do
  menu label: 'Products', priority: 4

  permit_params :name, :description, :price, :image, :category, :place_id

  index do
    selectable_column
    id_column
    column :name
    column :price do |item|
      format_currency item.price
    end
    column :place
    column :created_at
    actions
  end

  form do |f|  
    f.semantic_errors *f.object.errors.keys
    f.input :image, as: :file
    f.input :place
    f.input :name
    f.input :description, input_html: {rows: 2}
    f.input :price
    f.actions
  end

  show do
    panel "Product Information" do
      columns do
        column span: 4 do
          attributes_table_for resource do
            row :place
            row :name
            row :description
            row :price do 
              format_currency resource.price
            end
          end
        end
        if resource.image.attached? 
          column span: 1 do
            image_tag resource.image, class: 'width-100'
          end
        end
      end
    end
  end
end
