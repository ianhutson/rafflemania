class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.integer :raffle_id
      t.string :tier
      t.integer :cost

      t.timestamps
    end
  end
end
