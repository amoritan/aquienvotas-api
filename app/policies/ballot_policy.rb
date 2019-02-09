class BallotPolicy < ApplicationPolicy
  def show?
    user && !record.deleted? && (record.province.nil? ? true : record.province == user.province )
  end

  def vote?
    user && record.active? && (record.province.nil? ? true : record.province == user.province )
  end
end