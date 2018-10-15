class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :phone
      t.boolean :otp
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
