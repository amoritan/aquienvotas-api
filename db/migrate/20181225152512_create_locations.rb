class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :name
      t.bigint :population
      t.jsonb :demographics, default: { female: [ 0, 0, 0, 0, 0 ], male: [ 0, 0, 0, 0, 0 ] }
      t.references :province, type: :uuid, foreign_key: true
    end
  end
end
