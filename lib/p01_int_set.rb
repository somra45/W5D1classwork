class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
      return true
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return true if @store[num]
    false
  end

  private

  def is_valid?(num)
    if num > @store.length || num < 0
      raise 'Out of bounds'
    else
      return true
    end
  end

  def validate!(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] = num
    true
  end

  def remove(num)
    self[num] = []
  end

  def include?(num)
    @store.include?(num)
  end

  private

  def []=(num, target)
    @store[num % num_buckets] = target
  end

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    if count < num_buckets && !self.include?(num)
        self[num] = num 
        @count += 1
    elsif count >= num_buckets
      self.resize!
      self.insert(num)
    end
  end

  def remove(num)
    if self.include?(num)
      self[num] -= num
      @count -= 1
    end
  end

  def include?(num)
    @store.include?(num)
  end

  private
  attr_writer :num_buckets
  def num_buckets
    @store.length
  end

  def resize!
      @num_buckets = 2 * @num_buckets
      new_store = Array.new(@num_buckets) {Array.new}
      @store.each do |ele|
        if ele.is_a?(Integer)
          new_store[ele % @num_buckets] = ele
        end
      end
      @store = new_store
  end

  def []=(num, target)
    @store[num % num_buckets] = target
  end

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end
end