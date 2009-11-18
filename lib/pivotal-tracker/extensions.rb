# TODO make these conditional on to_param not existing...
class String
  def to_param
    self
  end
end

class Integer
  def to_param
    to_s
  end
end

module HappyMapper
  def ==(other)
    if self.class.elements.size != other.class.elements.size
      return false
    end
    self.class.elements.each do |element|
      return false if self.send(element.name.to_sym) != other.send(element.name.to_sym)
    end

    true
  end
end
