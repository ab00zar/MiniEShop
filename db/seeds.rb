products = [
  { code: 'MUG', name: 'Reedsy Mug', price: 6.00 },
  { code: 'TSHIRT', name: 'Reedsy T-shirt', price: 15.00 },
  { code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.00 }
]

products.each do |product_data|
  Product.find_or_create_by!(code: product_data[:code]) do |product|
    product.name = product_data[:name]
    product.price = product_data[:price]
  end
end

mug = Product.find_by(code: 'MUG')
tshirt = Product.find_by(code: 'TSHIRT')

Discount.find_or_create_by!(product: tshirt, min_quantity: 3) do |discount|
  discount.percentage = 30.0
end

(10..149).step(10) do |min_quantity|
  max_quantity = min_quantity + 9
  percentage = ((min_quantity / 10) * 2).to_f
  Discount.find_or_create_by!(product: mug, min_quantity: min_quantity, max_quantity: max_quantity) do |discount|
    discount.percentage = percentage
  end
end

Discount.find_or_create_by!(product: mug, min_quantity: 150) do |discount|
  discount.percentage = 30.0
end

puts "Good news! Products and discounts seeded successfully!"
