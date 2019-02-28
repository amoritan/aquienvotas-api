class BallotPolicy < ApplicationPolicy
  def show?
    !record.deleted?
  end

  def vote?
    user && record.active? && (record.province.nil? ? true : record.province == user.province )
  end
end