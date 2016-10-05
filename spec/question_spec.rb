require 'rspec'
require_relative '../question'

RSpec.describe Question do
	let(:question) { Question.new("Please enter your name", "USERNAME") }

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

		it "should update data" do
			expect(question.update_data).to eq ["Please enter your name", nil]
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