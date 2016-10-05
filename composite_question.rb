class CompositeQuestion < Question
  def initialize(body, identifier, answers, pointer = nil)
	super(body, identifier, pointer)
	@answers = answers
  end

  def print_question
  	super()
    puts "choose one of the following (number)"
    @answers.each_with_index { |a,i| puts "#{i+1}) #{a}"}
  end

  def get_input
    gets.gsub("\n","").to_i - 1
  end

  def update_data
    @data[@identifier] = [@body, @answers[@input]]
  end

  def next_question
    if final_question?
      update_listener
      return puts "thank you"
    end
    @input = 0 if @subquestions.size == 1
    @subquestions[@input].data = @data
    @subquestions[@input].add_listener(@bot)
    @subquestions[@input].execute
  end

end
