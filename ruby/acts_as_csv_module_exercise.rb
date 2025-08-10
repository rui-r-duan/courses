# author: Ryan Duan

module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    include Enumerable

    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
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

    def each(&block)
      return enum_for(__method__) if block.nil?
      @csv_contents.each do |x|
        block.call(CsvRow.new(x, @headers))
      end
    end
  end
end

class RubyCsv  # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv
end

class CsvRow
  attr :row, :headers

  # There is an inherent defect in this approach: if :name is one of Ruby's
  # reserved keywords that represents a method, such as :class, then
  # :method_missing will not be called.  So it requires that the header of the
  # CSV file cannot be the Ruby keywords, such as "class".
  def method_missing name, *args
    # parameter :name's class is Symbol, so call to_s to convert it to String
    i = @headers.find_index(name.to_s)
    @row[i]
  end

  def initialize(r, h)
    @row = r
    @headers = h
  end
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
