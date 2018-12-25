class CreateProvinces < ActiveRecord::Migration[5.2]
  def change
    create_table :provinces, id: :uuid do |t|
      t.string :name
      t.string :origin_id, limit: 6
    end
    add_index :provinces, :origin_id, unique: true
  end
end
