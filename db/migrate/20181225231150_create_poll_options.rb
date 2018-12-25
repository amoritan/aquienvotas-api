class CreatePollOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :poll_options, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :color, limit: 6
      t.integer :status, limit: 1, default: 1
      t.references :poll, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
