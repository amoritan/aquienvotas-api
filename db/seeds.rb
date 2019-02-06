# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

provinces = [
  { name: "Ciudad Autónoma de Buenos Aires", code: "AR-C", locations: [ { name: "Ciudad Autónoma de Buenos Aires", population: 3112284, demographics: { female: [ 186484, 426370, 392963, 220558, 405546 ], male: [ 192397, 429456, 384609, 201829, 272072 ] } } ] },
  { name: "Buenos Aires", code: "AR-B", locations: [ { name: "Gran Buenos Aires", population: 8224184, demographics: { female: [ 706724, 1225892, 998278, 524040, 780540 ], male: [ 732603, 1249216, 968976, 476731, 561183 ] } }, { name: "Interior de Buenos Aires", population: 442841, demographics: { female: [ 380543, 660096, 537535, 282175, 420291 ], male: [ 394479, 672655, 521757, 256701, 302175 ] } } ] },
  { name: "Catamarca", code: "AR-K", locations: [ { name: "Catamarca", population: 295908, demographics: { female: [ 31396, 46049, 34161, 16553, 21486 ], male: [ 32138, 46263, 34023, 16483, 17356 ] } } ] },
  { name: "Chaco", code: "AR-H", locations: [ { name: "Chaco", population: 910109, demographics: { female: [ 101227, 150233, 99762, 50735, 58770 ], male: [ 103195, 147533, 99050, 51088, 48516 ] } } ] },
  { name: "Chubut", code: "AR-U", locations: [ { name: "Chubut", population: 463444, demographics: { female: [ 42487, 74728, 55449, 26519, 32115 ], male: [ 44266, 77732, 56842, 26740, 26566 ] } } ] },
  { name: "Córdoba", code: "AR-X", locations: [ { name: "Córdoba", population: 2939122, demographics: { female: [ 256914, 437740, 344062, 185816, 283762 ], male: [ 263863, 443037, 339618, 173906, 210404 ] } } ] },
  { name: "Corrientes", code: "AR-W", locations: [ { name: "Corrientes", population: 868206, demographics: { female: [ 92787, 134984, 96844, 51119, 63118 ], male: [ 95468, 135486, 95570, 51077, 51753 ] } } ] },
  { name: "Entre Ríos", code: "AR-E", locations: [ { name: "Entre Ríos", population: 1068764, demographics: { female: [ 101314, 160195, 122650, 66203, 95491 ], male: [ 104945, 161129, 122822, 62859, 71156 ] } } ] },
  { name: "Formosa", code: "AR-P", locations: [ { name: "Formosa", population: 468360, demographics: { female: [ 52715, 70329, 51790, 27223, 34389 ], male: [ 54052, 68640, 50637, 27497, 31088 ] } } ] },
  { name: "Jujuy", code: "AR-Y", locations: [ { name: "Jujuy", population: 570645, demographics: { female: [ 60751, 90679, 67755, 32491, 39402 ], male: [ 62357, 89590, 65388, 29692, 32540 ] } } ] },
  { name: "La Pampa", code: "AR-L", locations: [ { name: "La Pampa", population: 287705, demographics: { female: [ 24776, 42364, 33068, 17945, 27276 ], male: [ 25838, 43326, 33321, 17959, 21832 ] } } ] },
  { name: "La Rioja", code: "AR-F", locations: [ { name: "La Rioja", population: 289322, demographics: { female: [ 30011, 46630, 33331, 15991, 18646 ], male: [ 30505, 46852, 33961, 16039, 17356 ] } } ] },
  { name: "Mendoza", code: "AR-M", locations: [ { name: "Mendoza", population: 1454658, demographics: { female: [ 130552, 219864, 170431, 91025, 137582 ], male: [ 134430, 222819, 162524, 82713, 102718 ] } } ] },
  { name: "Misiones", code: "AR-N", locations: [ { name: "Misiones", population: 941262, demographics: { female: [ 109069, 148378, 103323, 53336, 59311 ], male: [ 110780, 146955, 103138, 54115, 52857 ] } } ] },
  { name: "Neuquén", code: "AR-Q", locations: [ { name: "Neuquén", population: 539382, demographics: { female: [ 48171, 87370, 66595, 31388, 35036 ], male: [ 50763, 92008, 67321, 30914, 29816 ] } } ] },
  { name: "Río Negro", code: "AR-R", locations: [ { name: "Río Negro", population: 590142, demographics: { female: [ 52800, 91942, 70698, 35791, 46038 ], male: [ 55109, 93192, 70316, 35200, 39056 ] } } ] },
  { name: "Salta", code: "AR-A", locations: [ { name: "Salta", population: 1040340, demographics: { female: [ 117314, 165845, 119389, 56671, 70315 ], male: [ 119634, 163107, 115799, 54375, 57891 ] } } ] },
  { name: "San Juan", code: "AR-J", locations: [ { name: "San Juan", population: 563868, demographics: { female: [ 57097, 85134, 66027, 34065, 35859 ], male: [ 58747, 85240, 63099, 30438, 48162 ] } } ] },
  { name: "San Luis", code: "AR-D", locations: [ { name: "San Luis", population: 393339, demographics: { female: [ 38479, 59348, 46021, 22866, 30107 ], male: [ 39914, 60230, 47873, 23461, 25040 ] } } ] },
  { name: "Santa Cruz", code: "AR-Z", locations: [ { name: "Santa Cruz", population: 263699, demographics: { female: [ 24672, 45371, 30400, 13251, 13221 ], male: [ 26394, 50611, 32988, 14545, 12246 ] } } ] },
  { name: "Santa Fe", code: "AR-S", locations: [ { name: "Santa Fe", population: 2753259, demographics: { female: [ 231876, 417550, 319164, 175783, 276358 ], male: [ 238349, 419814, 313933, 164270, 196162 ] } } ] },
  { name: "Santiago del Estero", code: "AR-G", locations: [ { name: "Santiago del Estero", population: 747607, demographics: { female: [ 86295, 118648, 81981, 39464, 49203 ], male: [ 87502, 118295, 83581, 40448, 42190 ] } } ] },
  { name: "Tierra del Fuego, Antártida e Islas del Atlántico Sur", code: "AR-V", locations: [ { name: "Tierra del Fuego, Antártida e Islas del Atlántico Sur", population: 145525, demographics: { female: [ 13227, 25967, 16920, 8073, 5722 ], male: [ 14268, 28864, 18142, 9031, 5311 ] } } ] },
  { name: "Tucumán", code: "AR-T", locations: [ { name: "Tucumán", population: 1245996, demographics: { female: [ 128943, 193574, 142654, 75840, 97619 ], male: [ 130706, 191518, 138541, 70546, 76055 ] } } ] }
]

provinces.each do |province|
  _province = Province.create(name: province[:name], code: province[:code])
  province[:locations].each do |location|
    Location.create(name: location[:name], population: location[:population], demographics: location[:demographics], province: _province)
  end
end

redParty = Party.create(name: 'Red Party', description: 'The Red Party', color: 'ff0000')
greenParty = Party.create(name: 'Green Party', description: 'The Green Party', color: '00ff00')
blueParty = Party.create(name: 'Blue Party', description: 'The Blue Party', color: '0000ff')

candidateA = Candidate.create(name: 'AAA', description: 'AAA for the Red Party', party: redParty)
candidateB = Candidate.create(name: 'BBB', description: 'BBB for the Green Party', party: greenParty)
candidateC = Candidate.create(name: 'CCC', description: 'CCC for the Blue Party', party: blueParty)

ballotDemo = Ballot.create(name: 'Ballot Demo', expires_at: Time.now + 1.years, candidates: [candidateA, candidateB, candidateC])

# pollDemo = Poll.create(name: 'Poll Demo', expires_at: Time.now + 1.years)

# PollOption.create(name: 'Black', description: 'Black Color', color: '000000', poll: pollDemo)
# PollOption.create(name: 'White', description: 'White Color', color: 'ffffff', poll: pollDemo)
