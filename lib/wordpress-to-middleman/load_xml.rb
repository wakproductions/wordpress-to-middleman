require 'wordpress-to-middleman/parse_cdata'

module WordpressToMiddleman
  class LoadXML
    include ParseCDATA
    attr_reader :posts, :xml_file

    def initialize(filename)
      @xml_file = filename
      @posts = []
    end

    def xml_content_to_hash
      f = File.open(xml_file)
      xml = Nokogiri::XML(f)
      posts = xml.css('item')

      posts.each do |post|
        next if post.xpath('wp:post_type').text != 'post' # other type of post_type is 'attachment' for images
        next if post.xpath('wp:status').text != 'publish'

        ph = Hashie::Mash.new
        ph[:title] = post.css('title').text.gsub(":", "-") # ':' would cause a problem in YAML frontmatter
        ph[:post_name] = post.xpath('wp:post_name').text # will be used to build the Middleman filename
        ph[:pubDate] = Time.parse(post.css('pubDate').text)
        ph[:post_id] = post.xpath('wp:post_id').text
        ph[:content] = extract_from_cdata(post.xpath('content:encoded').text)
        ph[:categories] = []

        categories_xml = post.xpath("category")
        categories_xml.each do |category|
          # Only supports Wordpress categories right now, not Wordpress tags
          if category.css("@domain").to_s == "category"
            ph[:categories] << extract_from_cdata(category.text)
          end
        end

        @posts << ph
      end

      @posts
    end
  end
end
