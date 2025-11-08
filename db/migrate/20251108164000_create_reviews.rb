class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.references :booking, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :professional_profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
