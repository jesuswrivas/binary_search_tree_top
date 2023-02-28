require_relative "bst.rb"

class Tree

    attr_accessor :root

    def initialize(array)
        @root = build_tree(array)
    end


    def build_tree(array)
        #We remove the duplicates and sort
        #array.uniq!.sort!
        #Base case for our recursive function
        return nil if array.length == 0
        
        #Recursion
        root = Node.new(array[array.length/2])
        root.left = build_tree(array[0, array.length/2])
        root.right= build_tree(array[array.length/2 + 1, array.length])

        return root        
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end


    def search(root = self.root,key)
        #Base Case
        return root if root == nil || root.data == key
        #Recursion
        return search(root.left,key) if root.data > key
        return search(root.right,key) if root.data < key
    end

    def insert(root= self.root,key)

        if root == nil
            return Node.new(key)    

        else
            if root.data < key
                root.right = insert(root.right, key)            
            else
                root.left = insert(root.left, key)

            end

            return root
              
        end

    end


#This function returns the antecessor of the key
    def antecessor(root= self.root, key)
         #Base Case
         if root.right != nil
            return root if root.right.data == key 
         end

         if root.left != nil
            return root if root.left.data == key 
         end
         
         #Recursion
         return antecessor(root.left,key) if root.data > key
         return antecessor(root.right,key) if root.data < key
        
     end


     def next_hight_node(key)
        node_delete = self.search(key)
        next_hight_node = node_delete.right

        while next_hight_node.left != nil
            next_hight_node = next_hight_node.left
            
        end
        
        return next_hight_node
        
     end

     
     def delete(key)
        node_delete = self.search(key)
        parent = self.antecessor(node_delete.data)
       
        if node_delete.leaf?
            if parent.right == node_delete
                parent.right = nil
            else
                parent.left = nil
            end
        
        elsif node_delete.one_child?
            if parent.right == node_delete
                parent.right = node_delete.only_child
            else
                parent.left = node_delete.only_child
            end

        else
            second_highest_node = self.delete(self.next_hight_node(node_delete.data).data)
            second_highest_node.right = node_delete.right
            second_highest_node.left = node_delete.left

            if parent.right == node_delete
                parent.right = second_highest_node
            else
                parent.left = second_highest_node
            end

        end
        return node_delete
     end



end


newArray = [1,2,3,4,5,6,7]
newTree = Tree.new(newArray)
newTree.insert(15)
newTree.insert(33)
newTree.insert(14)
newTree.insert(13)
newTree.insert(34)
newTree.insert(35)
newTree.insert(28)



var7 = newTree.search(7)
var28 = newTree.search(28)
var14 = newTree.search(14)
var13 = newTree.search(13)
var33 = newTree.search(33)
var28 = newTree.search(28)
var34 = newTree.search(34)
var35 = newTree.search(35)

