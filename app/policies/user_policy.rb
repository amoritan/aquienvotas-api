class UserPolicy < ApplicationPolicy
  def update?
    user && record == user && (user.location.nil? || user.gender.nil? || user.age.nil?)
  end
end