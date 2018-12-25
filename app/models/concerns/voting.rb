module Voting
  extend ActiveSupport::Concern

  included do
    enum status: [ :deleted, :active, :archived ]
  end

  def state
    self.active? && DateTime.now() >= self[:expires_at] ? "expired" : self[:status]
  end
end
