require 'optparse'
require 'pp'

options = {
  :separator => /[,\t]/,
  :padding => 1,
  :skip => 0,
  :comment => /^#/
}

OptionParser.new do |opts|
  opts.banner = 'Usage: example.rb [options]'
  opts.separator ''
  opts.separator 'Options:'
  opts.separator '-' * 80

  opts.on('-s', '--separator [REGEX]',
          'regex to match the separator',
          '  default: [,\t]') do |s|
    begin
      options[:separator] = Regexp.new(s)
    rescue
      puts 'Warning: Problems encountered during processing the regex.'
      # TODO: regex isn't shown properly
      puts "Warning: Default value \"#{options[:separator]}\" is used."
    end
  end

  opts.on('-p', '--padding [NUM_OF_SPACES]',
          'number of spaces that separate the columns',
          '  default: 1') do |p|
    options[:padding] = p.to_i
  end

  opts.on('-k', '--skip [NUM_OF_LINES]',
          'number of top lines to skip',
          '  default: 0') do |k|
    options[:skip] = k.to_i
  end

  opts.on('-c', '--comment [REGEX]',
          'regex to match lines to ignore',
          '  default: ^#') do |c|
    begin
      options[:comment] = Regexp.new(c)
    rescue
      puts 'Warning: Problems encountered during processing the regex.'
      # TODO: regex isn't shown properly
      puts "Warning: Default value \"#{options[:comment]}\" is used."
    end
  end
end.parse!

if ARGV.empty?
  abort 'Error: No filename found.'
else
  file_name = ARGV[0]
end

if !File.exists? file_name
  abort "Error: file \"#{file_name}\" not found."
end

# TODO: write a similar loop as the main loop to do estimation
#       so that comments are properly ignored
# TODO: can the magic number 100 be included in options?
# TODO: add an option for choosing left or right justify
cell_lengths = File.foreach(file_name).first(100 + options[:skip]).drop(options[:skip])
  .map{|x|x.chomp.split(options[:separator]).map{|x|x.length}}

max_widths = []
cell_lengths.map(&:length).max.times do |i|
  max_widths[i] = 100.times.map{|j|cell_lengths[j][i]}.max
end

File.foreach(file_name).with_index do |line, lnum|
  if lnum < options[:skip] or line =~ options[:comment] then
    print line
    next
  end
  line.chomp.split(options[:separator]).each_with_index do |c, i|
    if max_widths[i] < c.length then max_widths[i] = c.length end
    print c.ljust(max_widths[i] + options[:padding]) rescue break
  end
  print "\n" rescue break
end
