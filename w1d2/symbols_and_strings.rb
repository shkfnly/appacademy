def super_print(str, options = {})
  default = {
    :times   => 1,
    :upcase  => false,
    :reverse => false
  }

  options = default.merge(options)

  options[:times].times do
    output = str
    output = output.upcase if options[:upcase]
    output = output.reverse if options[:reverse]
    puts output
  end
end

options = {times: 2, upcase: true, reverse: true}
super_print("hello", options)
