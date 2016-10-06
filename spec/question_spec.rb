require 'rspec'
require_relative '../basic_question'
require_relative '../bot'
require_relative '../question'

RSpec.describe Question do

	before(:all) do
	  @question = Question.new("Please enter your name", "USERNAME")
	  @bot = Bot.new 
      @question.add_listener(@bot)
    end

	context "question initialization" do 
		it "should initialize body" do 
			expect(@question.body).to eq("Please enter your name")
		end

		it "should initialize identifier" do 
			expect(@question.identifier).to eq("USERNAME")
		end

		it "pointer should be nil" do 
			expect(@question.pointer).to eq(nil)
		end
	end

	context "#execute" do
		it "should print body" do 
			expect do
				@question.print_question
			end.to output("Please enter your name\n").to_stdout
		end

		it "should update data" do
			expect(@question.update_listener).to eq ["Please enter your name", nil]
		end
	end

	context "#add_question" do 
		it "should have subquestion" do 
			@question.add_question(@question)
			expect(@question.subquestion).not_to be_nil
		end
	end
end