class UnisHanoi
  def self.transform(name, year)

    if name.nil? || name.empty? || year.nil? 
      raise ArgumentError, "invalid name #{name} or year #{year}"
    end

    # foo@example.com -> foo
    if name.match(/^(\w+)@/)
      name = $1
    end

    begin
      year = year.to_i
    rescue Exception => e
      raise ArgumentError, "couldn't convert #{year} to an integer"
    end
    raise ArgumentError, "invalid year #{year}" if year < 0

    # 2012 -> 12
    if year >= 100
      year = year % 100
    end

    # 1 -> "01"
    year = sprintf("%02d", year)

    return "#{year}#{name}"
  end

  def self.url
    "http://blogs.unishanoi.org"
  end

end


