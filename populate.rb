=begin

population.rb is used to import a csv file to our DB, 
which for development purpose in Sqlite

To use the script u need to write

$ ruby populate.rb data.csv

The data should be in the form
key,value
key,value
key,value
	
=end

require 'sequel'
DB = Sequel.connect("sqlite://db/data.db")
items = DB[:items]
if ARGV[0].nil? then
	puts "NO FILE ENTERED \n\n "
	puts "Usage eg:- ruby populate.rb data.csv\n\n"
else
	file = File.open ARGV[0]
	file.each do |line|
		data = line.split(',')
		items.insert(:key => data[0].downcase,:value => data[1].downcase)
	end
end