class Memo < Post

  def read_from_console
    puts "New note (all that you write before the line \"end\")"

    line = nil
    @text = []

    while line != "end" do
      line = STDIN.gets.chomp
      @text << line
    end

    @text.pop
  end

  def to_strings
    time_string = "Created #{@created_at.strftime("%Y-%m-%d, %H-%M-%S")} \n\n"
    @text.unshift(time_string)
  end

  def to_db_hash
    super.merge({
                    'text' => @text.join('\n\r')
                })
  end

  def load_data(data_hash)
    super(data_hash)
    @text = data_hash['text'].split('\n\r')
  end
end