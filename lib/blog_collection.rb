require 'blog'
require 'csv'
require 'nokogiri'

class BlogCollection
  attr_reader :blogs

  def initialize(io, base_url)
    @blogs    = []
    @base_url = base_url

    csv = CSV.new(io)
    csv.each do |row|
      next if row[0].nil?
      next if row[1].nil?
      next if row[0].match(/^\s*#/)

      owner = row[0]
      blog  = row[1].match(/^\s*(\w+)/)[1]

      if block_given?
        owner, blog = yield [owner, blog]
      end

      begin
        @blogs.push(Blog.new(owner, blog, base_url))
      rescue RuntimeError => e
        STDERR.puts "couldn't generate Blog for #{owner} - #{blog} (#{e})"
        next
      end
    end
    raise RuntimeError, "no blogs imported" if @blogs.empty?
  end

  def to_opml(folder, category = nil)
    builder = Nokogiri::XML::Builder.new do
      opml(:version => "1.0") {
        body {
          outline(:title => folder, :text => folder) {
            self.blogs.each do |blog|

              if category && !category.empty?
                name = "#{blog.owner} (#{category})"
              else 
                name = blog.owner
              end

              outline(:title => name, :text => name, :xmlUrl => blog.to_feed_url(category))
            end
          } # outline
        } # body
      } # opml
    end # XML::bulder

    builder.to_xml
  end


end


