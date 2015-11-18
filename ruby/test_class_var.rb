class Parent
  @@foo = "foo"
  bar = "bar"
end

class Thing1 < Parent
  @@foo = "Thing1"
end

class Thing2 < Parent
  @@foo = "Thing2"
end
