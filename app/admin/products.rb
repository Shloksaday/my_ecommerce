ActiveAdmin.register Product do

  # ✅ Permit all required fields
  permit_params :name, :description, :price, :category_id, :image, :stock, :active

  filter :name
  filter :price
  filter :category
  filter :created_at

  # ✅ FORM
  form do |f|
    f.semantic_errors

    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :price
      f.input :category, as: :select, collection: Category.pluck(:name, :id)
      f.input :stock
      f.input :active
      f.input :image, as: :file
    end

    f.actions
  end

  # ✅ AUTO ASSIGN ADMIN USER
  controller do
    def build_new_resource
      super.tap do |product|
        product.user = current_user
      end
    end
  end

  # ✅ INDEX
  index do
    selectable_column
    id_column
    column :name
    column :price
    column :stock
    column :active
    column :category

    column "Image" do |product|
      if product.image.attached?
        image_tag product.image, size: "80x80"
      end
    end

    actions
  end

  # ✅ SHOW
  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock
      row :active
      row :category

      row :image do |product|
        if product.image.attached?
          image_tag product.image, size: "200x200"
        end
      end
    end
  end

end
