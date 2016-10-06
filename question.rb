class Question < BasicQuestion
  attr_reader :subquestion

  def initialize(body, identifier, pointer = nil)
    super(body, identifier, pointer)
  end

  def add_question(question)
    @subquestion = question
  end

  alias << add_question

  def update_data
    @data[@identifier] = [@body, @user_input]
  end

  def next_question
    unless subquestion
      update_listener
      return puts "thank you"
    end
    @subquestion.data = @data
    @subquestion.add_listener(@bot)
    @subquestion.ask
  end

end