class CreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.string :code
      t.datetime :validtime
      t.boolean :used
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
