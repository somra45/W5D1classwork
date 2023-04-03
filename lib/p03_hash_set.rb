class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if count < num_buckets
      self[key] = key
      @count += 1
      return true
    else
      self.resize!
      self.insert(key)
    end
  end

  def include?(key)
    @store.include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key] = nil
      @count -= 1
    end
  end

  private
  attr_writer :num_buckets
  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets = 2 * num_buckets
      new_store = Array.new(@num_buckets) {Array.new}
      @store.each do |ele|
        if ele != []
          new_store[ele % @num_buckets] = ele
        end
      end
      @store = new_store
  end

  def [](num)
    val = num.hash
    @store[val % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def []=(num, target)
    val = num.hash
    @store[val % num_buckets] = target
  end
end