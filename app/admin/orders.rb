ActiveAdmin.register Order do
  permit_params :status

  index do
    id_column
    column :user
    column :status
    column :total_price
    column :created_at
    actions

  end

  show do 
    attributes_table do
      row :user
      row :status
      row :total_price
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price

        form do |f|
          f.inputs do
            f.input :product
            f.input :status
            f.input :total_price
            f.input :user
          end
          f.actions
        end
      end
    end
  end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :total_price, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :total_price, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  

end