class CreateUserProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :user_properties do |t|
      t.boolean :active, default: true
      t.boolean :favorite, default: false
      t.boolean :contacted, default: false
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
