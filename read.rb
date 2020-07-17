require_relative  'post.rb'
require_relative  'memo.rb'
require_relative  'link.rb'
require_relative  'task.rb'

require 'optparse'

options = {}

OptionParser.new do |opt|
  opt.banner = 'Usage: read.rb [options]'

  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end
  opt.on('--type POST_TYPE', 'what type of posts to show (by default any)') { |o| options[:type] = o } #
  opt.on('--id POST_ID', 'if id is specified - show only this post in detail') { |o| options[:id] = o } #
  opt.on('--limit NUMBER', 'how many recent posts to show (all by default)') { |o| options[:limit] = o } #
end.parse!

result = if options[:id].nil?
           Post.find_all(options[:limit], options[:type])
         else
           Post.find_by_id(options[:id])
         end

if result.is_a? Post
  puts "Запись #{result.class.name}, id = #{options[:id]}"
  result.to_strings.each { |line| puts line }
else
  print '| id                 '
  print '| @type              '
  print '| @created_at        '
  print '| @text              '
  print '| @url               '
  print '| @due_date          '
  print '|'

  result.each do |row|
    puts
    row.each do |element|
      element_text = "| #{element.to_s.delete("\n\r")[0..17]}"
      element_text << ' ' * (21 - element_text.size)
      print element_text
    end
    print '|'
  end

  puts
end