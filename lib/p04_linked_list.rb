class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end

end

class LinkedList

  attr_accessor :head, :tail
  attr_reader :nodes
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = tail
    @tail.prev = head
    @nodes = []
  end

  def [](i)
    nodes.each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @nodes[0]
  end

  def last
    @nodes[-1]
  end

  def empty?
    nodes.empty?
  end

  def get(key)
    target = nodes.select { |node| node.key == key }
    return nil if target.empty?
    target[0].val
  end

  def include?(key)
    nodes.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    nodes << new_node
    if nodes.length == 1
      new_node.next = tail
      new_node.prev = head
      head.next = new_node
      tail.prev = new_node
    else
      new_node.next = tail
      new_node.prev = nodes[-1]
      nodes[-1].next = new_node
    end
  end

  def update(key, val)
    target = nodes.select { |node| node.key == key }
    return nil if target.empty?
    target[0].val = val
  end

  def remove(key)
    target = nodes.select { |node| node.key == key }
    return nil if target.empty?
    removed_index = nodes.index(target[0])
    nodes[removed_index-1].next = nodes[removed_index+1]
    nodes[removed_index+1].prev = nodes[removed_index-1]
    nodes.reject! { |node| node.key == key }
  end

  def each(&prc)
    nodes.each do |node|
      prc.call(node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end