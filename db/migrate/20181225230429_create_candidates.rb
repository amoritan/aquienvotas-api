########################################################################################
########################################################################################
####                                                                                ####
####  This file is part of AQuienVotas.                                             ####
####                                                                                ####
####  AQuienVotas is free software: you can redistribute it and/or modify           ####
####  it under the terms of the GNU Affero General Public License as published by   ####
####  the Free Software Foundation, either version 3 of the License, or             ####
####  (at your option) any later version.                                           ####
####                                                                                ####
####  AQuienVotas is distributed in the hope that it will be useful,                ####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of                ####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 ####
####  GNU Affero General Public License for more details.                           ####
####                                                                                ####
####  You should have received a copy of the GNU Affero General Public License      ####
####  along with AQuienVotas.  If not, see <https://www.gnu.org/licenses/>.         ####
####                                                                                ####
########################################################################################
########################################################################################



class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :color, limit: 6
      t.integer :status, limit: 1, default: 1
      t.references :party, type: :uuid, foreign_key: true

      t.timestamps
    end

    create_table :ballots_candidates, id: false do |t|
      t.references :ballot, type: :uuid, foreign_key: true
      t.references :candidate, type: :uuid, foreign_key: true
    end
  end
end
