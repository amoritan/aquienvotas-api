class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :account_id
      t.string :access_token
      t.datetime :access_token_expires_at
      t.references :location, type: :uuid, foreign_key: true
      t.integer :gender, limit: 1
      t.integer :age, limit: 1

      t.timestamps
    end
    add_index :users, :account_id, unique: true
  end
end
