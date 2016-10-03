class CompositeQuestion < Question
  def initialize(body, title, identifier, answers = [])
	super(body, title, identifier)
	@answers = answers
  end

  def print_question
  	super()
    puts "choose one of the following (number)"
    @answers.each_with_index { |a,i| puts "#{i+1}.) #{a}"}
  end

  def update_data
    @data[@identifier.to_sym] = @answers[@input-1]
  end

  def next_question
    @subquestions[@input-1].data = @data
    @subquestions[@input-1].execute
  end

end
