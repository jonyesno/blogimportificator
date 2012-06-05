require 'nokogiri'
require 'blog'

class BlogCollection
  attr_reader :blogs

  def initialize(io, base_url)
    @blogs    = []
    @base_url = base_url

    while line = io.gets
      next if line.nil? || line.empty?
      next if line.match(/^#/)
      next if line.match(/^\s+$/)
      name = line.match(/(\w+)/)[1]

      if block_given?
        name = yield name
      end

      begin
        @blogs.push(Blog.new(name, base_url))
      rescue RuntimeError => e
        STDERR.puts "couldn't generate Blog for #{name}"
        next
      end
    end
    raise RuntimeError, "no names imported" if @blogs.empty?
  end

  def to_opml(folder, category = nil)
    builder = Nokogiri::XML::Builder.new do
      opml(:version => "1.0") {
        body {
          outline(:title => folder, :text => folder) {
            self.blogs.each do |blog|

              if category && !category.empty?
                name = "#{blog.name} (#{category})"
              else 
                name = blog.name
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


