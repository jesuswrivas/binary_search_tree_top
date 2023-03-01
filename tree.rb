require_relative "bst.rb"

class Tree

    attr_accessor :root

    def initialize(array)
        @root = build_tree(array)
    end


    def build_tree(array)
        #We remove the duplicates and sort
        array.uniq!
        array.sort!

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

        #Checking if the key(node.data) is already on the tree. We cant have duplicates on this exercise
        return nil if self.search(key).data == key

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
       #Case when the node to be deleted is a leaf node
        if node_delete.leaf?
            if parent.right == node_delete
                parent.right = nil
            else
                parent.left = nil
            end
        #Case when the node has only one child
        elsif node_delete.one_child?
            if parent.right == node_delete
                parent.right = node_delete.only_child
            else
                parent.left = node_delete.only_child
            end
        #Case when the node to be deleted has two childs
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


     def level_order(root = self.root)
       
        queue = []
        list = []
        queue << root
 
        until queue.length == 0
            queue << queue[0].left if queue[0].left             
            queue << queue[0].right if queue[0].right
            current_value = (queue.shift)
            list << current_value
            yield(current_value) if block_given?
        end
       
        list unless block_given?
                             
    end

    def preorder(root = self.root,&block)

        return nil if root == nil
        
        block.call(root)
        preorder(root.left, &block)
        preorder(root.right, &block)

    end

    def inorder(root = self.root,&block)

        return nil if root == nil
        
        inorder(root.left, &block)
        block.call(root)
        inorder(root.right, &block)

    end

    def postorder(root = self.root,&block)

        return nil if root == nil
               
        postorder(root.left, &block)
        postorder(root.right, &block)
        block.call(root)

    end


    def height(root = self.root, counter = -1)

        counter += 1

        if root == nil
          return counter    
        end
      
        left_height = height(root.left, counter)
        right_height = height(root.right, counter)
      
        return [left_height, right_height].max
      end



    def depth(root = self.root, counter = 0, node)
        counter += 1

        if root == nil
            return 0
        end

        if root == node
            return counter
        end
    
        left = depth(root.left, counter, node)
        right = depth(root.right, counter, node)

        return [left, right].max

    end

    def balanced?
        left_side = self.height(self.root.left)
        right_side = self.height(self.root.right)

        return (left_side - right_side).abs <= 1

    end


    def rebalance
        auxArray = []
        self.preorder {|x| auxArray << x.data}
        auxArray.uniq!
        auxArray.sort!
        self.root = self.build_tree(auxArray)

    end


end


