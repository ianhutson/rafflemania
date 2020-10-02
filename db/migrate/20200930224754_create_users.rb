class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :shipping_address
      t.string :shipping_city_state_zip
      t.string :shipping_name
      t.string :email
      t.integer :tickets

      t.timestamps
    end
  end
end
