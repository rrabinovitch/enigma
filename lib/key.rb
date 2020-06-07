class Key
  def self.number
    '%05d' % rand(99999)
  end

  def self.abcd_keys
    key_hash = {A: number.slice(0..1),
      B: number.slice(1..2),
      C: number.slice(2..3),
      D: number.slice(3..4)}
  end
end



# def key
#   '%05d' % rand(99999)
# end
