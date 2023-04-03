class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    key = rand(0..1)
    bit_array = self.map {|el| el.to_s.bytes }
    result = []
    bit_array.each do |ele|
      result += ele ^ key.to_s(2)
    end
    hash_value = result.pack("*C")
    return hash_value
  end
end

class String
  def hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end