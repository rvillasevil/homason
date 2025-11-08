class CreateSubscriptionPlans < ActiveRecord::Migration[8.0]
  def change
    create_table :subscription_plans do |t|
      t.string :name
      t.integer :price_cents
      t.integer :yearly_hours
      t.string :description
      t.boolean :active

      t.timestamps
    end
  end
end
