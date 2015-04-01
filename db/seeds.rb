# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(:email => "rishabh@creatiosoft.com", :password => "@creatiosoft", :password_confirmation => "@creatiosoft", :role => "admin")
user.save


normal_rooms = ["Statue_of_Liberty_USA", "Great_Wall_of_China", "Mt_Rushmore", "Las_Vegas", "Hawai_Islands", "Machu_Picchu", "Hollywood", "Christ_Statue_Rio", "Golden_Gate_Bridge_USA", "The_Colosseum_Rome", "Pyramids_of_Giza", "Stonehenge_England", "Eiffel_Tower_Paris", "Opera_House_Sydney", "Leaning_Tower_of_PisaItaly"]
special_rooms = ["Speed_Bingo", "Pure_Bingo", "Reverse_Bingo", "QuickShot_Bingo", "BetBingo", "Multiple_Bingo", "TreasureHunt_Bingo", "Crazy_Bingo", "Solid_Bingo", "BlackOut_Bingo"]
tournament_rooms = ["Daily_Free", "Weekly", "Monthly"]

normal_rooms.each do |room_name|
	RoomConfig.create(name: room_name, room_type: "Normal")
end

special_rooms.each do |room_name|
	RoomConfig.create(name: room_name, room_type: "Special")
end

tournament_rooms.each do |room_name|
	RoomConfig.create(name: room_name, room_type: "Tournament")
end