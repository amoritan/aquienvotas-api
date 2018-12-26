class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :voting, type: :uuid, polymorphic: true
      t.references :choice, type: :uuid, polymorphic: true

      t.timestamps
    end
  end
end
