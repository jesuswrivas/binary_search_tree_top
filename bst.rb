class Node
    attr_accessor :data, :left, :right

    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end


    def leaf?
        return true if @left == nil && @right == nil
        return false
    end

    def one_child?
        return (@left && @right) == nil
    end

    def only_child
        return nil if @left == nil && @right == nil
        return nil if @left && @right

        return @left || @right
    end
end