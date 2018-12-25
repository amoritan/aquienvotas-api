class CreateBallots < ActiveRecord::Migration[5.2]
  def change
    create_table :ballots, id: :uuid do |t|
      t.string :name
      t.integer :status, limit: 1, default: 1
      t.datetime :expires_at
      t.references :province, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
