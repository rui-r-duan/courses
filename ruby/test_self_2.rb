class Post
  attr_accessor :title

  def replace_title(new_title)
    self.title = new_title
  end

  def print_title
    puts title
  end
end

pst = Post.new
pst.title = "Cream of Broccoli"
pst.replace_title("Cream of Spinach")
pst.print_title
