class UnisHanoi
  def self.transform(owner, blog, year)

    if blog.nil? || blog.empty? || year.nil? 
      raise ArgumentError, "invalid blog #{blog} or year #{year}"
    end

    # foo@example.com -> foo
    if blog.match(/^(\w+)@/)
      blog = $1
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

    return [owner, "#{year}#{blog}" ]
  end

  def self.url
    "http://blogs.unishanoi.org"
  end

end


