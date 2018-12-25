class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :color, limit: 6
      t.integer :status, limit: 1, default: 1
      t.references :party, type: :uuid, foreign_key: true

      t.timestamps
    end

    create_table :ballots_candidates, id: false do |t|
      t.references :ballot, type: :uuid, foreign_key: true
      t.references :candidate, type: :uuid, foreign_key: true
    end
  end
end
