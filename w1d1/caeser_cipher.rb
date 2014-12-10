def cc(str, shifter)
  split_str = str.split("")
  split_str.map! do |x|
    if x.ord + shifter > 122
      ((x.ord + shifter) - 26).chr
    else
      (x.ord + shifter).chr
    end
  end
  split_str.join('')
end

puts cc("hello", 3)
