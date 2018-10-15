class CreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.string :code
      t.datetime :valid
      t.boolean :valid
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
