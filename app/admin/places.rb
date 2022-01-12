ActiveAdmin.register Place do

  permit_params :name, :description, :place_category_id, :status, :latlong, :website, :contact_number, :image

  index do
    selectable_column 
    id_column
    column :name
    column :place_category
    column :website
    column :contact_number
    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.input :image, as: :file
    f.input :name
    f.input :description
    f.input :place_category
    f.input :status
    f.input :latlong
    f.input :website
    f.input :contact_number
    f.actions
  end
  
  show do
    panel "" do
      tabs do
        tab "General Information" do
          columns do 
            column span: 3 do 
              attributes_table_for place do
                row :id
                row :name
                row :description
                row :place_category
                row :status do 
                  status_tag place.status
                end
                row :latlong
                row :website
                row :contact_number
                row :created_at
                row :updated_at
              end
            end
            if place.image.attached? 
              column do
                image_tag place.image, style: 'width: 100%'
              end
            end
          end
        end
        tab "Reviews" do
          resource.reviews.each do |review|
            br

            div do
              a review.user.name, href: admin_user_path(review.user) 
              render 'rating_star', rating: review.rating
              div do
                para review.content
              end
            end
          end
        end
      end
    end
    
  end
end
