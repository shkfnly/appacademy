
def rps(param)
  choices = ['Rock', 'Paper', 'Scissors']
  computer_choice = choices.sample
  puts comparison(param, computer_choice)
end

def comparison(player_choice, computer_choice)
  if player_choice == computer_choice
    "#{player_choice}, Draw"
  else

    case player_choice
    when 'Rock'
      computer_choice == 'Paper' ? "#{computer_choice}, Lose" :
        "#{computer_choice}, Win"
    when 'Paper'
      computer_choice == 'Scissors' ? "#{computer_choice}, Lose" :
        "#{computer_choice}, Win"
    when 'Scissors'
      computer_choice == 'Rock' ? "#{computer_choice}, Lose" :
        "#{computer_choice}, Win"
    end
  end
end

def remix(arr)
  alcohol, mixer = [], []

  arr.each do |alc, mix|
    alcohol << alc
    mixer << mix
  end

  alcohol.shuffle!
  mixer.shuffle!

  result = []
  alcohol.each_with_index do |alc, index|
    result << [alc, mixer[index]]
  end
  result
end

p remix([
  ["rum", "coke"],
  ["gin", "tonic"],
  ["scotch", "soda"]
])
