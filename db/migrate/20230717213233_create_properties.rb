class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.text :operation
      t.text :address
      t.integer :price
      t.integer :maintenance
      t.boolean :pets
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :area
      t.text :description
      t.string :photo

      t.timestamps
    end
  end
end
