require 'cuba'
require 'cuba/render'
require 'sequel'

Cuba.plugin Cuba::Render

Cuba.use Rack::Static,
root: "./",
urls: ["/assets"]

DB = Sequel.connect("sqlite://data.db")
items = DB[:items]

Cuba.define do
	on root do
		on param('txtweb-message') do |msg|
			dataset = items.where(:key => msg.downcase)
			data = "Not present in DB"
			dataset.each do |item|
				data = item[:value]
			end
			res.write render('response.html.erb',data:data)
		end

		on default do
			res.write render('response.html.erb',data:"data")
		end
	end

	on "enter" do
		on post do
			on param('data') do |data|
				res.write data
				p data.scan(/<p>(.*?)<\/p>/imu).flatten.flatten.to_s.split("<br />")[0]
				p "here"
			end
		end
		on default do
			res.write render('submit_form.html.erb')
		end
	end

	on "insert" do
		on get do
			res.write render('insert.html.erb')
		end
		on post do
			on param('key'),param('value') do |key,value|
				items.insert(:key => key, :value => value)
				res.write "key: #{key} with value: #{value} has been inserted"
			end
		end
	end

	on "view" do
		on get do
			items = DB[:items]
			res.write render('view.html.erb',data:items)
		end
	end
end