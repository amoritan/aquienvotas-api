class PollPolicy < ApplicationPolicy
  def show?
    user && !record.deleted?
  end

  def vote?
    user && record.active?
  end
end