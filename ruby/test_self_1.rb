class Post
  attr_writer :title

  def self.author
    "Jimmy"
  end

  def full_title
    "#{@title} by #{self.class.author}"
  end
end

pst = Post.new
pst.title = "Delicious Ham"
puts pst.full_title
puts Post.author
# puts Post.title # undefined method `title' for Post:Class
