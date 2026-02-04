ActiveAdmin.register Product do
  permit_params :name, :price, :description, :active, :image

  filter :name
  filter :price
  filter :active
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :active

    column "Image" do |product|
      if product.image.attached?
        image_tag url_for(product.image), size: "80x80"
      end
    end

    actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :description
      row :active

      row :image do |product|
        image_tag url_for(product.image), size: "200x200" if product.image.attached?
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :description
      f.input :active
      f.input :image, as: :file
    end
    f.actions
  end
end
