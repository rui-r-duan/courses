#---
# Excerpted from "Seven Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/btlang for more book information.
#
# Modified by Ryan Duan
#---
module ActsAsCsv
  def read
    @csv_contents = []
    filename = self.class.to_s.downcase + '.txt'
    puts filename
    file = File.new(filename)
    @headers = file.gets.chomp.split(', ')

    file.each do |row|
      @csv_contents << row.chomp.split(', ')
    end
  end
  
  attr_accessor :headers, :csv_contents
  def initialize
    read 
  end
end

class RubyCsv  # no inheritance! You can mix it in
  #include ActsAsCsv
end

m = RubyCsv.new
m.extend(ActsAsCsv)
m.read        # must call it explicitly, because we cannot call initialize again
puts m.headers.inspect
puts m.csv_contents.inspect
