require_relative "basic_question"
require_relative "question"
require_relative "composite_question"
require_relative "migration"
require_relative "user"
require_relative "message"

class Bot
	attr_accessor :data, :start_question

	def initialize
		@data = {}
	end

	def start_conversation
		@start_question.add_listener(self)
		@start_question.ask
		user = User.create!(name: @data["USERNAME"][1])
		store_data(user, @data)
	end

	def update(identifier, body, user_input)
		@data[identifier] = [body, user_input]
	end

	def store_data(user, data)
		User.transaction do 
			@data.each_pair { |k,v|
				user.messages.create!([{ body: v[0] }, { body: v[1] }])
			}
		end
	end

	def show_collected_data
		user = User.last
		messages = user.messages.pluck(:body)
		puts "#{user.name} has #{user.messages.count} messages: #{messages.join(', ')}."
	end
end