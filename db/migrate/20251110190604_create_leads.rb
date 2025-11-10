class CreateLeads < ActiveRecord::Migration[8.0]
  def change
    create_table :leads do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone
      t.string :status, null: false, default: "new"
      t.string :source
      t.text :notes
      t.references :customer, foreign_key: { to_table: :users }
      t.references :professional_profile, foreign_key: true
      t.datetime :follow_up_at

      t.timestamps
    end

    add_index :leads, :status
    add_index :leads, :follow_up_at

    add_column :bookings, :attachments, :jsonb, default: [], null: false
    add_column :users, :phone, :string
    add_column :users, :address, :string
  end
end
