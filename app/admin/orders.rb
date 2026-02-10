ActiveAdmin.register Order do
  permit_params :user_id, :product_id, :status, :total_price

  filter :id
  filter :status, as: :select, collection: Order.statuses.keys
  filter :user
  filter :product
  filter :created_at

  index do
    selectable_column
    id_column
    column :user
    column :product
    column :status
    column :total_price
    column :created_at
    actions
  end
end
