require 'sequel'
DB = Sequel.connect('sqlite://data.db')

DB.create_table :items do
	primary_id :id
	String  :key
	String :value
end