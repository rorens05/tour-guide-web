ActiveAdmin.register Transaction do

  permit_params :account_id, :category_id, :amount, :note, :schedule, :status, :image
  
  
  form do |f|  
    f.semantic_errors *f.object.errors.keys
    f.input :image, as: :file

    f.input :account, member_label: :label_name, include_blank: false
    f.input :category
    f.input :amount
    f.input :note
    f.input :schedule, as: :datetime_picker
    f.input :status
    f.actions
  end

  index do
    selectable_column
    id_column
    column :account
    column :category
    column :amount do |transaction|
      format_currency(transaction.amount)
    end

    column :type, sortable: "categories.transaction_type" do |transaction|
      status_tag transaction.category.transaction_type
    end
    
    column :status do |transaction|
      status_tag transaction.status
    end
    column :created_at
    
    actions
  end 

  controller do
    def scoped_collection
      super.includes :category
    end
  end
end
