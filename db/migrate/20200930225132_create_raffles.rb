class CreateRaffles < ActiveRecord::Migration[6.0]
  def change
    create_table :raffles do |t|
      t.string :product_name
      t.string :product_description
      t.string :product_image
      t.integer :number_of_ticket_slots

      t.timestamps
    end
  end
end
