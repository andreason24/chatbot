class CompositeQuestion < BasicQuestion
  attr_reader :subquestions

  def initialize(body, identifier, answers, pointer = nil)
	super(body, identifier, pointer)
	@answers = answers
  @subquestions = []
  end

  def add_question(question)
    @subquestions << question
  end

  alias << add_question

  def [](index)
    @subquestions[index]
  end

  def []=(index, question)
    @subquestions[index] = question
  end

  def print_question
  	super()
    puts "choose one of the following (number)"
    @answers.each_with_index { |a,i| puts "#{i+1}) #{a}"}
  end

  def get_input
    @user_input = gets.chomp.to_i - 1
    number_of_answers = @answers.size
    if @user_input < 0 || @user_input >= number_of_answers
      puts "please write a number between numbers 1 and #{number_of_answers}, inclusive"
      get_input
    end
  end

  def update_data
    @data[@identifier] = [@body, @answers[@user_input]]
  end

  def final_question?
    subquestions.empty?
  end

  def next_question
    if final_question?
      update_listener
      return puts "thank you"
    end
    @user_input = 0 if @subquestions.size == 1
    @subquestions[@user_input].data = @data
    @subquestions[@user_input].add_listener(@bot)
    @subquestions[@user_input].ask
  end

end
