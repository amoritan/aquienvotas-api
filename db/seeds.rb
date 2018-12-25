# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

provinces = HTTP.get("https://apis.datos.gob.ar/georef/api/provincias").parse
provinces["provincias"].each do |province|
  _province = Province.create(name: province["nombre"], origin_id: province["id"])
  puts "Province #{province["nombre"]} was created"
  cities = HTTP.get("https://apis.datos.gob.ar/georef/api/departamentos?provincia=#{province["id"]}&max=1000").parse
  cities["departamentos"].each do |city|
    City.create(name: city["nombre"], origin_id: city["id"], province: _province)
    puts "City #{city["nombre"]} was created at province #{province["nombre"]}"
  end
end
