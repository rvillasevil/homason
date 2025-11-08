class CreateProfessionalProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :professional_profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.integer :years_experience, null: false
      t.string :zone, null: false
      t.integer :day_rate, null: false, default: 200
      t.boolean :verified, default: false
      t.float :rating_avg, default: 0.0
      t.integer :rating_count, default: 0

      t.timestamps
    end
  end
end
