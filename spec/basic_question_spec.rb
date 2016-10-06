require 'rspec'
require_relative '../basic_question'

RSpec.describe BasicQuestion do
	let(:question) { BasicQuestion.new("Please enter your name", "USERNAME") }

	context "question initialization" do 
		it "should initialize body" do 
			expect(question.body).to eq("Please enter your name")
		end

		it "should initialize identifier" do 
			expect(question.identifier).to eq("USERNAME")
		end

		it "pointer should be nil" do 
			expect(question.pointer).to eq(nil)
		end
	end

	context "#execute" do
		it "should print body" do 
			expect do
				question.print_question
			end.to output("Please enter your name\n").to_stdout
		end
	end
end