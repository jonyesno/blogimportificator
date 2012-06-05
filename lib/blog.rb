class Blog
  attr_reader :name

  def initialize(name, base_url)
    @name = Blog.validate_name(name)
    @base_url = base_url
  end

  def to_blog_url
    "#{@base_url}/#{self.name}"
  end

  def to_feed_url(category = nil)
    if category && !category.empty?
      url = "#{self.to_blog_url}/#{category}/feed"
    else
      url = "#{self.to_blog_url}/feed"
    end
  end

  def self.validate_name(name)
    raise RuntimeError, "invalid name #{name}" if name.nil? || name.empty?
    raise RuntimeError, "invalid name #{name}" unless name.match(/^[\w\-_]+$/)
    return name
  end
end


