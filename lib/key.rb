class Key
  def self.generate
    '%05d' % rand(99999)
  end
end


# be able to make a guess re: return value of '%37d' % rand(99999) 
