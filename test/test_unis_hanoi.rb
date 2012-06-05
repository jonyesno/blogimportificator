require 'test/unit'
require 'unis_hanoi'

class TestUnisHanoi < Test::Unit::TestCase
  def test_simple
    assert_equal ["Foo Bar", "12foo"], UnisHanoi.transform("Foo Bar", "foo", "12")
    assert_equal ["Foo Bar", "12foo"], UnisHanoi.transform("Foo Bar", "foo", 12)
  end

  def test_downcase
    assert_equal ["Foo Bar", "12foo"], UnisHanoi.transform("Foo Bar", "FOO", "12")
  end

  def test_email
    assert_equal ["Foo Bar", "12foo"], UnisHanoi.transform("Foo Bar", "foo@example.com", "12")
  end

  def test_validation
    assert_raises ArgumentError do
      UnisHanoi.transform("", nil)
    end
    assert_raises ArgumentError do
      UnisHanoi.transform("foo", -1)
    end
  end
end

