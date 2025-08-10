class Colors
  include Enumerable

  def each
    yield "r"
    yield "g"
    yield "b"
  end

  def each(&block)
    @result_arr.each(&block)
  end

  def each(&block)
    return enum_for(__method__) if block.nil?
    @result_arr.each do |ob|
      block.call(ob)
    end
  end

  def initialize
    @result_arr = ["red", "green", "blue"]
  end
end
