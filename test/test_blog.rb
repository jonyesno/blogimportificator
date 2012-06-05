require 'test/unit'
require 'blog'

class TestBlog < Test::Unit::TestCase

  def test_new
    b = Blog.new("Foo Bar", "foo", "example.com")
    assert_equal "foo",  b.blog
  end

  def test_validation
    assert_raise RuntimeError do
      Blog.new("Foo Bar", "foo@example.com", "example.com") 
    end
    assert_raise RuntimeError do
      Blog.new("Foo Bar", "''", "example.com") 
    end
  end

  def test_blog_urls
    b = Blog.new("Foo Bar", "foo", "http://example.com")
    assert_equal "http://example.com/foo", b.to_blog_url
    assert_equal "http://example.com/foo/feed", b.to_feed_url
    assert_equal "http://example.com/foo/category/lemons/feed", b.to_feed_url('lemons')
  end

end
