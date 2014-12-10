def hanoi
  first, second, third = [1, 2, 3], [], []
  board = [first, second, third]
  marker = true
  while marker
    puts "What and Where do you want to move? (column to column)"
    print first[0], second[0], third[0]
    puts ''
    response = gets.chomp.split(',')
    response = response.map { |x| x.to_i - 1 }

    unless board[response[0]].nil? && board[response[0]].first > board[reponse[1]].first

      board[response[1]].unshift(board[response[0]].shift)

    else
      puts "Invalid Move"
    end
    if (board[2].sort == board[2]) && (board[2].count == first.count + second.count + third.count)
      marker = false
    end
  end
  puts "You Win!"
end
hanoi
