require 'test/unit'
require 'blog_collection'

class TestBlogCollection < Test::Unit::TestCase

  def setup
    data = DATA.tell
    @bc ||= BlogCollection.new(DATA, 'example.com')
    DATA.seek(data)
  end

  def test_read_file
    assert_not_equal 0, @bc.blogs
  end

  def test_transform_names
    data = DATA.tell
    bc = BlogCollection.new(DATA, 'example.com') do |name|
      name = name + "-transformed"
    end
    DATA.seek(data)
    assert bc.blogs.first.name.match(/-transformed$/)
  end

  def test_make_feeds_no_category
    xml = @bc.to_opml('citrus')
    assert_match(%r{<opml version="1.0"}, xml)
    assert_match(%r{<outline title="citrus"}, xml)
  end

  def test_make_feeds_with_category
    xml = @bc.to_opml('citrus', 'lemons')
    assert_match(%r{<opml version="1.0"}, xml)
    assert_match(%r{<outline title="foo \(lemons\)"}, xml)
  end

end

