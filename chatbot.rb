
require_relative "question"
require "pry"
require_relative "composite_question"
require_relative "migration"

start = Question.new("Hello, what is your name?", "name")

second = Question.new("name, how old are you?", "age", "name")
start.add_question second

third = CompositeQuestion.new("okey name, what is the best way to contact with you?", "info", "name", ["by email","by phone", "by skype"])

second.add_question third

third_first = Question.new("please, tell your email","email")
third_second = Question.new("please, tell your phone","phone")
third_third = Question.new("please, tell your skype", "skype")

third << third_first
third << third_second
third << third_third

four = CompositeQuestion.new("we will contact with you by email", "end", nil, ["ok","thanks", "good luck"] )

third_first << four

five = Question.new("just some end question", "end")

four << five

class Chatbot

	def initialize
		@start_question
		@data
	end

	def add_question(question)
		@start_question = question
	end

	def execute
		# binding.pry
		user = User.create!(name: 'Big Bang')
		@start_question.add_listener(self)
		@start_question.execute
		store_data(user, @data)
		messages = user.messages.pluck(:body)
		puts "#{user.name} has #{user.messages} messages #{messages.join(', ')}."
	end

	def update(data)
		@data = data
	end

	def store_data(user,data)
		@data.each_pair { |k,v|
			user.messages.create!(body: v[0])
			user.messages.create!(body: v[1])
		}
	end

end

bot = Chatbot.new
bot.add_question(start)
bot.execute