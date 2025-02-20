class Ship
  attr_reader :name, :length
  def initialize(name,length)
    @name = name
    @length = length
    @hit = true
  end

  def health
    @length
  end


end