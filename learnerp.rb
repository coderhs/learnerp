require 'cuba'
require 'cuba/render'

Cuba.define do
	on root do
		on params('txtweb-message') do |msg|
			res.write "wasu"
		end
	end
end