require 'sequel'
DB = Sequel.connect('sqlite://db/data.db')

DB.create_table :items do
	primary_id :id
	String  :key
	String :value
end

DB.create_table :unknown do
	primary_id :id
	String :key
end