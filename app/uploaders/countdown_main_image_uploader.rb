class CountdownMainImageUploader < ImageUploader

  version :thumb do
    process resize_to_fill: [500, 500]
  end

end

