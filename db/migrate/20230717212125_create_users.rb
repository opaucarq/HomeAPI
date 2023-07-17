class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :role
      t.text :name
      t.string :email
      t.string :phone
      t.string :password

      t.timestamps
    end
  end
end
