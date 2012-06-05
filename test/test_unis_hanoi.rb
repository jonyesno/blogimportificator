require 'test/unit'
require 'unis_hanoi'

class TestUnisHanoi < Test::Unit::TestCase
  def test_simple
    assert_equal "12foo", UnisHanoi.transform("foo", "12")
    assert_equal "12foo", UnisHanoi.transform("foo", 12)
  end

  def test_email
    assert_equal "12foo", UnisHanoi.transform("foo@example.com", "12")
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

