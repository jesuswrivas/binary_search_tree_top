require_relative "bst.rb"

class Tree

    attr_accessor :root

    def initialize(array)
        @root = build_tree(array)
    end


    def build_tree(array)
        return nil if array.length == 0
        
        root = Node.new(array[array.length/2])
        root.left = build_tree(array[0, array.length/2])
        root.right= build_tree(array[array.length/2 + 1, array.length])

        return root        
    end
end

newArray = [1,2,3,4,5,6,7]
newTree = Tree.new(newArray)





