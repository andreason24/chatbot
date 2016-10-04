require "pry"
class Question
  attr_accessor :body, :pointer, :identifier, :data, :bot
  attr_reader :subquestions, :input

  def initialize(body, identifier, pointer = nil)
    @body = body
    @pointer = pointer
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

  def final_question?
    subquestions.empty?
  end

  def execute
    print_question
    @input = get_input
    update_data
    next_question
  end

  def print_question
    @body.gsub!("#{@pointer}", @data[@pointer][1]) if @data.key?(@pointer) && @pointer
    puts @body
  end

  def get_input
    gets.gsub("\n","")
  end

  def update_data
    @data[@identifier] = [@body, @input]
    update_listener
  end

  def next_question
    if final_question?
      return puts "thank you, collected data #{@data}"
    end
    @subquestions[0].data = @data
    @subquestions[0].add_listener(@bot)
    @subquestions[0].execute
  end

  def add_listener(bot)
    @bot = bot
  end

  def update_listener
    @bot.update(@data)
  end

end


