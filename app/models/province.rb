class Province < ApplicationRecord
  has_many :locations
  has_many :ballots
  has_many :users, through: :locations

  def active_ballot
    self.ballots.where(status: :active).order(:created_at).last
  end
end
