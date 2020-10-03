class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :password_digest_confirm
      t.string :shipping_address
      t.string :city
      t.string :state
      t.string :zip
      t.string :shipping_name
      t.integer :tickets

      t.timestamps
    end
  end
end
