class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls, id: :uuid do |t|
      t.string :name
      t.integer :status, limit: 1, default: 1
      t.datetime :expires_at

      t.timestamps
    end
  end
end
