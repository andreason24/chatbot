require_relative "question"
require_relative "composite_question"
require_relative "migration"
require_relative "user"
require_relative "message"

class Chatbot

	attr_accessor :data, :start_question

	def initialize
		@data = {}
	end

	def ask_question
		@start_question.add_listener(self)
		@start_question.execute
		user = User.create!(name: @data["USERNAME"][1])
		store_data(user, @data)
	end

	def update(data)
		@data = data
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

start_question = Question.new("Please enter your name", "USERNAME")
contacts = CompositeQuestion.new("Hello USERNAME, How can we reach you out to you?", "contacts", 
								["phone", "Email", "I don't want to be contacted"], "USERNAME")
start_question << contacts

phone = Question.new("Please type your phone number", "contact_choise")
email = Question.new("Please type your email address", "contact_choise")
contact_failed = Question.new("Sad to hear that. Whenever you change your mind - feel free to send me a message",
							  "failed")
contacts << phone
contacts << email
contacts << contact_failed

contact_time = CompositeQuestion.new("What is the best time we can reach out to you?", "contact_time",
									["ASAP", "Morning", "Aftermoon", "Evening"])
phone << contact_time

contact_by_phone = CompositeQuestion.new("we are going to contact you using contact_choise", "contact", 
								["Yes, please", "Sorry, wrong phone"], "contact_choise")
contact_by_email = CompositeQuestion.new("we are going to contact you using contact_choise", "contact", 
								["Yes, please", "Sorry, wrong email"], "contact_choise")
contact_time << contact_by_phone
email << contact_by_email
end_message = Question.new("Happy end. You can add anything you want", "end")
contact_by_email << end_message
contact_by_phone << end_message
contact_by_email << email
contact_by_phone << phone

bot = Chatbot.new
bot.start_question = start_question
bot.ask_question
bot.show_collected_data