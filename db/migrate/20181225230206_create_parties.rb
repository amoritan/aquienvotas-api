class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :color, limit: 6
      t.integer :status, limit: 1, default: 1

      t.timestamps
    end
  end
end
