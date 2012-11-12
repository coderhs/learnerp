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
			res.write "<meta name='textweb-appkey' content='c6775e48-8dd9-4a22-b927-408db2761b58' />"
			res.write "test"
		end
	end
end