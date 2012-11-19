require 'cuba'
require 'cuba/render'
require 'sequel'

Cuba.plugin Cuba::Render

Cuba.use Rack::Static,
root: "./",
urls: ["/assets"]

DB = Sequel.connect("sqlite://db/data.db")
items = DB[:items]

Cuba.define do
	on root do
		on param('txtweb-message') do |msg|
			dataset = items.where(:key => msg.downcase)
			data = "Not present in DB"
			dataset.each do |item|
				data = item[:value]
			end
			if data == "Not present in DB" then
				DB[:unknown].insert(:key => msg.downcase)
			end
			res.write render('view/response.html.erb',data:data)
		end

		on default do
			res.write render('view/response.html.erb',data:"data")
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
			res.write render('view/submit_form.html.erb')
		end
	end

	on "insert" do
		on get do
			res.write render('view/insert.html.erb')
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
			on param("val") do |val|
				data = " "
				if val == "db" then
					data = DB[:items]
					res.write render('view/view.html.erb',data:data)
				elsif val == "unknown" then
					data = DB[:unknown]
					res.write render('view/unknown.html.erb',data:data)
				else
					res.redirect 'view'
				end					
				
			end
			on default do
				res.write "view?val=db/unknown"
			end
		end
	end
end
