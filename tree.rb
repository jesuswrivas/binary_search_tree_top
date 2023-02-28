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
        end
                  
     end



end




newArray = [1,2,3,4,5,6,7]
newTree = Tree.new(newArray)
newTree.insert(22)
newTree.insert(33)





