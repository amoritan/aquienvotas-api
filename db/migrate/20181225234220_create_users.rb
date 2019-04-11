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



class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :account_id
      t.string :access_token
      t.datetime :access_token_expires_at
      t.references :location, type: :uuid, foreign_key: true
      t.integer :gender, limit: 1
      t.integer :age, limit: 1

      t.timestamps
    end
    add_index :users, :account_id, unique: true
  end
end
