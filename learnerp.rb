require 'cuba'
require 'cuba/render'
Cuba.plugin Cuba::Render

Cuba.define do
	on root do
		on param('txtweb-message') do |msg|
			res.write render('response.html.erb',data:msg)
		end

		on default do
			res.write render('response.html.erb',data:"data")
		end
	end
end