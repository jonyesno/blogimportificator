require 'test/unit'
require 'cleaner'

class TestCleaner < Test::Unit::TestCase

	def test_blank
		assert_equal([ "blank", nil ], Cleaner.clean(""))
		assert_equal([ "blank", nil ], Cleaner.clean("\n"))
		assert_equal([ "blank", nil ], Cleaner.clean(" "))
	end

	def test_known_headers
		assert_equal([ "contact group header", nil ], Cleaner.clean("Contact Group Name:	Grade 8\n"))
		assert_equal([ "members header",       nil ], Cleaner.clean("Members:	 \n"))
	end

	def test_email_line
		assert_equal([ "ok", '"foo bar","foobar@example.com"' ], Cleaner.clean("foo bar    foobar@example.com\n"))
	end

	def test_inner_commas
		assert_equal([ "ok", '"foo,bar","foobar@example.com"' ], Cleaner.clean("foo,bar    foobar@example.com\n"))
	end

	def test_non_email_line
		assert_equal([ "ok", '"foo bar","foobar"' ], Cleaner.clean("foo bar    foobar\n"))
	end

	def test_single_word_unrecognised
		assert_equal([ "unrecognised", nil ], Cleaner.clean("foo"))
	end
end


