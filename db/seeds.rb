Product.find_each do |product|
  image_path = Rails.root.join("db/seed_images/#{product.name.parameterize}.jpg")

  if File.exist?(image_path)
    product.image.attach(
      io: File.open(image_path),
      filename: File.basename(image_path)
    )
  end
end
