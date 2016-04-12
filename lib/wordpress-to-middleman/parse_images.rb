module WordpressToMiddleman
  class ParseImages
    attr_reader :base_url, :original_content, :parsed_content

    def initialize(original_content, base_url)
      @base_url = base_url
      @original_content = original_content
      @parsed_content = ''
    end

    def extract_filename(full_url)
      strip_thumbnail_reference(full_url.gsub("#{base_url}wp-content/uploads/", ""))
    end

    # This formats images for a custom image partial used at GreenspudTrades.com
    # Change this around to meet the needs of your own website
    def image_partial(image_url, caption_text)
      <<PARTIAL
<%= partial 'image', locals: { filename: '#{extract_filename(image_url)}', caption: '#{sanitize_caption_text(caption_text)}'} %>
PARTIAL
    end

    def insert_newlines_before_image_partials
      partials = @parsed_content.scan /<%= partial.*?%>/m
      return if partials.empty?
      partials.each do |p|
        index = @parsed_content.index(p[0])
        if index > 0 && @parsed_content[index-1] != "\n"
          @parsed_content.insert(index - 1, "\n\n")
        end
      end
    end

    def parse_images
      @parsed_content = original_content
      parse_images_with_captions
      parse_images_without_captions
      insert_newlines_before_image_partials
    end

    def parse_images_with_captions
      matches = @parsed_content.scan /(\[caption.*?\/caption\])/m
      return if matches.nil?

      matches.each do |s|
        image_box_text = s[0]
        image_url = image_box_text.match(/href="(.*?)"/)[1]
        caption = image_box_text.match(/\[caption.*<\/a>(.*)\[\/caption\]/m)[1].strip

        @parsed_content.gsub!(image_box_text, image_partial(image_url, caption))
      end
      @parsed_content
    end

    def parse_images_without_captions
      matches = @parsed_content.scan(/(<a href.*?<\/a>)/m).select { |match| match[0].match /(<a href.*?<img.*?src="(.*?)".*?<\/a>)/m }
      return if matches.empty?

      matches.each do |s|
        image_box_text = s[0]
        image_url = extract_filename(image_box_text.match(/<a href.*?<img.*?src="(.*?)".*?<\/a>/m)[1])
        caption = ''

        @parsed_content.gsub!(image_box_text, image_partial(image_url, caption))
      end
      @parsed_content
    end

    def sanitize_caption_text(caption_text)
      caption_text.gsub("'", "''")
    end

    # Converts:
    # 2014/09/Screen-Shot-2014-09-07-at-8.09.21-PM-600x352.png -> 2014/09/Screen-Shot-2014-09-07-at-8.09.21-PM.png
    def strip_thumbnail_reference(filename)
      m = filename.match /(.*)-\d{1,4}x\d{1,4}\.(png|jpg|jpeg|gif)/
      m ? "#{m[1]}.#{m[2]}" : filename
    end
  end
end