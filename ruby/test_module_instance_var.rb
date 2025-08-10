module Notes
  attr  :concertA
  def tuning(amt)
    @concertA = 440.0 + amt
  end
end

class Trumpet
  include Notes
  def initialize(tune)
    tuning(tune)
    puts "Instance method returns #{concertA}"
    puts "Instance variable is #{@concertA}"
  end
end

# The piano is a little flat, so we'll match it
Trumpet.new(-5.3)

puts

#----------------------------------------------------------------
module MajorScales
  def majorNum
    @numNotes = 7 if @numNotes.nil?
    puts "@numNotes object id: #{@numNotes.object_id}"
    @numNotes                   # Return 7?
  end
end

module PentatonicScales
  def pentaNum
    @numNotes = 5 if @numNotes.nil?
    puts "@numNotes object id: #{@numNotes.object_id}"
    @numNotes                   # Return 5?
  end
end

class ScaleDemo
  include MajorScales
  include PentatonicScales
  def initialize
    puts majorNum # Should be 7
    puts pentaNum # Should be 5
  end
end

ScaleDemo.new
