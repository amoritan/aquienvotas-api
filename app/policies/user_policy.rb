class UserPolicy < ApplicationPolicy
  def update?
    user && record == user && (user.location.nil? || user.gender.nil? || user.age.nil?)
  end

  def demographics?
    user && !user.gender.nil? && !user.age.nil?
  end

  def locations?
    user && !user.location.nil?
  end
end