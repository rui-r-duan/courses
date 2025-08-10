class Tree
  attr_accessor :children, :node_name # node_name is String, children is Array

  # Can we overload the initialize function like that in C++?
  # No. The second 'def' overrides the first 'def' of the same function signiture.

  # null node is denoted by [] or {}, nil is not allowed
  def initialize(t = {})
    if t.size == 0
      @children = @node_name = nil

    # assume t is a single root tree, so t.to_a contains only one element.
    else

      if t.class == Hash
        # t is of the form {node => children}
        # t.to_a is of the form [[node, children]]
        a = t.to_a[0]
      elsif t.class == Array
        # t must be of the form [node, children]
        a = t                   # Array.to_a returns the array itself
      end

      c = a[1]
      # c is either a Hash of the form {node=>{}}
      #     or an Array of the form [[node, []]]
      # Hash.each produce an Array of the form [node, children]
      # Array.each also produce an Array of the form [node, children]
      #
      # e.g.
      # {:n=>{}}.each {|d| print "#{d}\n"}
      #    prints:
      # [:n, {}]
      # => {:n=>{}}
      #
      # [[:n, []]].each {|d| print "#{d}\n"}
      #    prints:
      # [:n, []]
      # => [[:n, []]]

      @children = []
      c.each { |child| @children.push(Tree.new(child)) }
      @node_name = a[0]         # assume hash is a single root tree
    end
  end

  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end

end

tree1 = Tree.new ({'grandpa' => 
                   { 'dad' => 
                     {'child 1' => {}, 'child 2' => {} },

                     'uncle' =>
                     {'child 3' => {}, 'child 4' => {}}
                   }
                  })

tree2 = 
  Tree.new([:g,
            [
              [:d, 
               [[:c1,[]], [:c2,[]]]
              ],
              [:u,
               [[:c3,[]], [:c4,[]]]
              ]
            ]
           ])

tree1.visit_all {|node| puts node.node_name}
tree2.visit_all {|node| puts node.node_name}
