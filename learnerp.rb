require 'cuba'
require 'cuba/render'

Cuba.define do
	on root do
		res.write "wasu"
	end
end