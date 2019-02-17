class Location < ApplicationRecord
  belongs_to :province
  has_many :users

  before_save :calculate_population

  private
    def calculate_population
      self.population = self.demographics.keys.inject(0){ |total, gender| total + self.demographics[gender].inject(0){ |sum, age| sum + age } }
    end
end
