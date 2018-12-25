class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities, id: :uuid do |t|
      t.string :name
      t.string :origin_id, limit: 6
      t.references :province, type: :uuid, foreign_key: true
    end
    add_index :cities, :origin_id, unique: true
  end
end
