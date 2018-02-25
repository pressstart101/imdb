
class Person
  attr_accessor :name, :photoURL, :profileUrl, :mostKnownWork

  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end
end
