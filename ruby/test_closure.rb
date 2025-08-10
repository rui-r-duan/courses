def add_n (n)
  lambda {|x| n + x}
end

a_proc = add_n(5)
# => #<Proc:0x00000001400f00@test_closure.rb:2 (lambda)>
a_proc.call(3)
# => 8
a_proc.call(10)
# => 15
