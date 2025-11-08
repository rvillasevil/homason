class CreateSubscriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subscription_plan, null: false, foreign_key: true
      t.boolean :active
      t.datetime :started_at
      t.datetime :cancelled_at
      t.integer :remaining_hours
      t.string :external_ref

      t.timestamps
    end
  end
end
