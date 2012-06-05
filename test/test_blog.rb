require 'test/unit'
require 'blog'

class TestBlog < Test::Unit::TestCase

  def test_new
    b = Blog.new("foo", "example.com")
    assert_equal "foo",  b.name
  end

  def test_validation
    assert_raise RuntimeError do
      Blog.new("foo@example.com", "example.com") 
    end
    assert_raise RuntimeError do
      Blog.new("''", "example.com") 
    end
  end

  def test_blog_urls
    b = Blog.new("foo", "http://example.com")
    assert_equal "http://example.com/foo", b.to_blog_url
    assert_equal "http://example.com/foo/feed", b.to_feed_url
    assert_equal "http://example.com/foo/lemons/feed", b.to_feed_url('lemons')
  end

end
