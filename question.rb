require "pry"
class Question
  attr_accessor :body, :title, :identifier, :data
  attr_reader :subquestions, :input

  def initialize(body, title, identifier)
    @body = body
    @title = title
    @identifier  = identifier
    @subquestions = []
    @data = {}
  end

  def add_question(question)
    @subquestions << question
  end

  alias << add_question

  def remove_question(question)
    @subquestions.delete question
  end

  def [](index)
    @subquestions[index]
  end

  def []=(index, question)
    @subquestions[index] = question
  end

  def final_question?
    subquestions.empty?
  end

  def execute
    print_question
    @input = gets.gsub("\n","")
    update_data
    next_question
  end

  def print_question
    key = @identifier.to_sym
    @body.gsub!("#{@identifier}",@data[key]) if @data.key?(key)
    puts @body
  end

  def update_data
    #save_question
    @data[@identifier.to_sym] = @input
  end

  def next_question
    @subquestions[0].data = @data
    @subquestions[0].execute
  end

end


