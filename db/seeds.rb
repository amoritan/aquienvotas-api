# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# provinces = HTTP.get("https://apis.datos.gob.ar/georef/api/provincias").parse
# provinces["provincias"].each do |province|
#   _province = Province.create(name: province["nombre"], origin_id: province["id"])
#   puts "Province #{province["nombre"]} was created"
#   cities = HTTP.get("https://apis.datos.gob.ar/georef/api/departamentos?provincia=#{province["id"]}&max=1000").parse
#   cities["departamentos"].each do |city|
#     City.create(name: city["nombre"], origin_id: city["id"], province: _province)
#     puts "City #{city["nombre"]} was created at province #{province["nombre"]}"
#   end
# end

redParty = Party.create(name: 'Red Party', description: 'The Red Party', color: 'ff0000')
greenParty = Party.create(name: 'Green Party', description: 'The Green Party', color: '00ff00')
blueParty = Party.create(name: 'Blue Party', description: 'The Blue Party', color: '0000ff')

candidateA = Candidate.create(name: 'AAA', description: 'AAA for the Red Party', party: redParty)
candidateB = Candidate.create(name: 'BBB', description: 'BBB for the Green Party', party: greenParty)
candidateC = Candidate.create(name: 'CCC', description: 'CCC for the Blue Party', party: blueParty)

ballotDemo = Ballot.create(name: 'Ballot Demo', expires_at: Time.now + 1.years, candidates: [candidateA, candidateB, candidateC])

pollDemo = Poll.create(name: 'Poll Demo', expires_at: Time.now + 1.years)

PollOption.create(name: 'Black', description: 'Black Color', color: '000000', poll: pollDemo)
PollOption.create(name: 'White', description: 'White Color', color: 'ffffff', poll: pollDemo)
