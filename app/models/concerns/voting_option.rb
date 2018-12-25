module VotingOption
  extend ActiveSupport::Concern

  included do
    enum status: [ :deleted, :active, :archived ]
  end
end
