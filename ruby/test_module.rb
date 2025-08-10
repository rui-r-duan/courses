module Debug
  def whoAmI?
    "#{self.type} (\##{self.object_id}): #{self.to_s}"
  end
end
class Phonograph
  include Debug
  attr :type
  def initialize(type)
    @type = type
  end
end
class EightTrack
  include Debug
  attr :type
  def initialize(type)
    @type = type
  end
end

ph = Phonograph.new("West End Blues")
et = EightTrack.new("Surrealistic Pillow")
puts ph.whoAmI? #>> West End Blues (#20958660): #<Phonograph:0x000000027f9b88>
puts et.whoAmI? #>> Surrealistic Pillow (#20958620): #<EightTrack:0x000000027f9b38>

class Phonograph
  def to_s
    @type
  end
end
class EightTrack
    def to_s
    @type
  end
end

puts ph.whoAmI? #>> West End Blues (#20958660): West End Blues
puts et.whoAmI? #>> Surrealistic Pillow (#20958620): Surrealistic Pillow
