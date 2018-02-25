class MostKnownWork
  attr_accessor :title, :url, :rating, :director

  @@all = []


  # def mostKnownWork
  #   def title
  #     @title
  #   end
  # end

  # def mostKnownWork=(mostKnownWork)
  #   def title=(title)
  #     @title = title
  #   end
  # end




  def initialize
    @@all << self
  end

  def self.all
    @@all
  end
end