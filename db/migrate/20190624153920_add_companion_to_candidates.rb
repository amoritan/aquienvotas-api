class AddCompanionToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_reference :candidates, :companion, type: :uuid 
  end
end
