class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :voting, polymorphic: true
  belongs_to :choice, polymorphic: true
end
