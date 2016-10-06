require_relative "bot"


start_question = Question.new("Please enter your name", "USERNAME")
contacts = CompositeQuestion.new("Hello USERNAME, How can we reach you out to you?", "contacts", ["phone", "Email", "I don't want to be contacted"], "USERNAME")
phone = Question.new("Please type your phone number", "contact_choise")
email = Question.new("Please type your email address", "contact_choise")
contact_failed = Question.new("Sad to hear that. Whenever you change your mind - feel free to send us a message", "failed")
contact_time = CompositeQuestion.new("What is the best time we can reach out to you?", "contact_time", ["ASAP", "Morning", "Aftermoon", "Evening"])
contact_by_phone = CompositeQuestion.new("we are going to contact you using contact_choise", "contact", ["Yes, please", "Sorry, wrong phone"], "contact_choise")
contact_by_email = CompositeQuestion.new("we are going to contact you using contact_choise", "contact", ["Yes, please", "Sorry, wrong email"], "contact_choise")
end_message = Question.new("Happy end. You can add anything you want", "end")

start_question << contacts
				  contacts << phone
				  contacts << email
				  contacts << contact_failed
							  phone 	   << contact_time
							  contact_time << contact_by_phone
							  email 	   << contact_by_email
											  contact_by_email << end_message
											  contact_by_email << email
											  contact_by_phone << end_message
										      contact_by_phone << phone

bot = Bot.new
bot.start_question = start_question
bot.start_conversation
bot.show_collected_data