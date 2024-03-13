isarmstrong = fn a,b,c,d ->
  (a ** 3 + b ** 3 + c ** 3) == d
end

d = 153

IO.puts("Is #{d} an armstrong number?
#{isarmstrong.(1,5,3,d)}")
