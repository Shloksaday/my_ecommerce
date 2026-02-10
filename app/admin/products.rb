ActiveAdmin.register Product do
  permit_params :name, :description, :price, :category_id, :image

  filter :name
  filter :price
  filter :category
  filter :created_at

  form do |f|
    f.semantic_errors

    f.inputs "Product Details" do
      f.input :name
      f.input :description
      f.input :price
      f.input :category, as: :select, collection: Category.pluck(:name, :id)
      f.input :image, as: :file
    end

    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :category

    column "Image" do |product|
      if product.image.attached?
        image_tag product.image, size: "80x80"
      end
    end

    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :category

      row :image do |product|
        if product.image.attached?
          image_tag product.image, size: "200x200"
        end
      end
    end
  end
end
