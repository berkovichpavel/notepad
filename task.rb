require "date"

class Task < Post
  def initialize
    super
    @due_date = Time.now
  end

  def read_from_console
    puts "What should be done?"
    @text = STDIN.gets.chomp

    puts "To what date? Indicate the date and time in the DD.MM.YYYY format, for example, 10.17.2000"
    input = STDIN.gets.chomp

    @due_date = Date.parse(input)
  end

  def to_strings
    time_string = "Created #{@created_at.strftime("%Y-%m-%d, %H-%M-%S")} \n\n"
    deadline = "Deadline: #{@due_date}"
    [deadline, @text, time_string]
  end

  def to_db_hash
    super.merge({
                    'text' => @text,
                    'due_date' => @due_date.to_s
                })
  end

  def load_data(data_hash)
    super(data_hash)
    @due_date = Date.parse(data_hash['due_date'])
    @text = data_hash['text'].split('\n\r')

  end
end

