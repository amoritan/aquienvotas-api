class CreateProvinces < ActiveRecord::Migration[5.2]
  def change
    create_table :provinces, id: :uuid do |t|
      t.string :name
      t.string :code, limit: 4
    end
    add_index :provinces, :code, unique: true
  end
end
