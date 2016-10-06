#body - текст запитання
#identifier - викорестовується для того щоб зберегти введені дані під певним ключевим словом
#pointer - указує на ключове слово(використовується в тих випадках коли потрібно замінити слово 
#з тексту(body) на одну з попередніх відповідей користувача) 
class BasicQuestion
  attr_accessor :body, :identifier, :pointer, :data, :bot
  attr_reader :user_input

  def initialize(body, identifier, pointer = nil)
    @body = body
    @pointer = pointer
    @identifier  = identifier
    @data = {}
  end

  def ask
    print_question
    get_input
    update_data
    next_question
  end

  def print_question
    @body.gsub!("#{@pointer}", @data[@pointer][1]) if @data.key?(@pointer) && @pointer
    puts @body
  end

  def get_input
    @user_input = gets.chomp
  end

  def add_listener(bot)
    @bot = bot
  end

  def update_data
    raise NotImplementedError
  end

  def update_listener
    @bot.update(@data)
  end

  def next_question
    raise NotImplementedError
  end
end