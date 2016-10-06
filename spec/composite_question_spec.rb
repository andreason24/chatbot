require 'rspec'
require_relative '../basic_question'
require_relative '../composite_question'


RSpec.describe CompositeQuestion do
	let(:question) { CompositeQuestion.new("Hello USERNAME, How can we reach you out to you?", "contacts", 
								["phone", "Email", "I don't want to be contacted"], "USERNAME") }

	context "#print_question" do
		it "should print correct message" do
			expect do
				question.data = { "USERNAME" => ["#{@body}", "Andrew"] }
				question.print_question
			end.to output(start_with("Hello Andrew, How can we reach you out to you?\n")).to_stdout
		end		
	end

	context "#add_question" do 
		it "should have subquestion" do 
			question.add_question(question)
			expect(question.subquestions.size).to eq 1
		end
	end

	context "#final_question?" do
		it "should return true" do
			expect(question.final_question?).to be_truthy 
		end

		it "should return false" do
			question.add_question(question)
			expect(question.final_question?).to be_falsey
		end
	end

end