class Blog
  attr_reader :blog, :owner

  def initialize(owner, blog, base_url)
    @owner = Blog.validate_owner(owner)
    @blog  = Blog.validate_blog(blog)
    @base_url = base_url
  end

  def to_blog_url
    "#{@base_url}/#{self.blog}"
  end

  def to_feed_url(category = nil)
    if category && !category.empty?
      url = "#{self.to_blog_url}/category/#{category}/feed"
    else
      url = "#{self.to_blog_url}/feed"
    end
  end

  def self.validate_blog(blog)
    raise RuntimeError, "invalid blog #{blog}" if blog.nil? || blog.empty?
    raise RuntimeError, "invalid blog #{blog}" unless blog.match(/^[\w\-_]+$/)
    blog
  end

  def self.validate_owner(owner)
    owner
  end
end


