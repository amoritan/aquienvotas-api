class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :phone
      t.string :token
      t.references :city, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
