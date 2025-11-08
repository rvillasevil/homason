class CreateMaterialOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :material_orders do |t|
      t.references :booking, null: false, foreign_key: true, index: { unique: true }
      t.text :items_json, null: false
      t.integer :total_cost_cents, null: false
      t.integer :margin_cents, null: false
      t.string :status, null: false, default: "pending"
      t.string :provider_ref

      t.timestamps
    end
  end
end
