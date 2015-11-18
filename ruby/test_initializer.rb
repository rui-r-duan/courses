class Test
  attr_accessor :name

  def initialize(n)
    @name = n
  end

  def initialize(s = 0, t = nil)
    @name = s
  end
end
