class Admin::BallotPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.where.not(status: :deleted)
      else
        []
      end
    end
  end

  def show?
    user && user.admin? && !record.deleted?
  end

  def update?
    user && user.admin? && !record.deleted?
  end

  def create?
    user && user.admin?
  end
end