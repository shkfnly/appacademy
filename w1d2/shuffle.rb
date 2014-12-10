def shuffled(filename)
  file = open("#{filename}-shuffled.txt", 'w')
  file.write(File.readlines(filename).shuffle!)
  file.close
end

if __FILE__ == $PROGRAM_NAME
  filename = ARGV.first
  shuffled(filename)
end
