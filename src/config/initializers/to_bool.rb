class String
  def to_bool
    # return true if self == true || self =~ (/\A(true|t|yes|y|1|on)\Z/i)
    return true if self == true || self =~ (/\A(true|t|yes|y|on)\Z/i)
    # return false if self == false || self.blank? || self =~ (/\A(false|f|no|n|0|off)\Z/i)
    return false if self == false || self.blank? || self =~ (/\A(false|f|no|n|off)\Z/i)

    self
  end
end

class Object
  def to_bool
    self
  end
end
