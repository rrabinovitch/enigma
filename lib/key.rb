class Key
  def self.generate
    '%05d' % rand(99999)
  end
end
