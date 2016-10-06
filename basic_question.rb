#body - текст запитання
#identifier - викорестовується для того щоб зберегти введені дані під певним ключевим словом
#pointer - указує на ключове слово(використовується в тих випадках коли потрібно замінити слово 
#з тексту(body) на одну з попередніх відповідей користувача) 
class BasicQuestion
  attr_accessor :body, :identifier, :pointer, :bot
  attr_reader :user_input

  def initialize(body, identifier, pointer = nil)
    @body = body
    @pointer = pointer
    @identifier  = identifier
  end

  def ask
    print_question
    get_input
    update_listener
    next_question
  end

  def print_question
    @body.gsub!("#{@pointer}", @bot.data[@pointer][1]) if @bot.data.key?(@pointer) && @pointer
    puts @body
  end

  def get_input
    @user_input = gets.chomp
  end

  def add_listener(bot)
    @bot = bot
  end

  def update_listener
    raise NotImplementedError
  end

  def next_question
    raise NotImplementedError
  end
end