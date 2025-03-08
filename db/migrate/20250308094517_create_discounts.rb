class CreateDiscounts < ActiveRecord::Migration[8.0]
  def change
    create_table :discounts do |t|
      t.references :product, null: false, foreign_key: true
      t.integer :discount_type, null: false, default: 0
      t.integer :min_quantity, null: false
      t.integer :max_quantity
      t.decimal :percentage, precision: 5, scale: 2, null: false

      t.timestamps
    end
  end
end
