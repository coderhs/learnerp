require 'cuba'
require 'cuba/render'

Cuba.define do
	on root do
		on param('txtweb-message') do |msg|
			res.write "#{msg} recieved at RubyKitchen"
			res.write "
			"
		end

		on default do
			res.write "test"
		end
	end
end