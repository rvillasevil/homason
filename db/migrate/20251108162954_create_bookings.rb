class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.references :professional_profile, foreign_key: true
      t.datetime :date, null: false
      t.integer :days, null: false, default: 1
      t.string :status, null: false, default: "pending"
      t.string :address, null: false
      t.text :description, null: false
      t.references :subscription, foreign_key: true

      t.timestamps
    end
  end
end
