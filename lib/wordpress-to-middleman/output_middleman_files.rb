module WordpressToMiddleman
  class OutputMiddlemanFiles

    attr_reader :content, :extension, :output_dir

    def initialize(article_contents, output_dir, ext='.html.md.erb')
      @content = article_contents
      @output_dir = output_dir
      @extension = ext
    end

    def generate
      @content.each do |article|
        output_file(article)
      end
    end

    private

    def build_filename(article)
      year = article[:pubDate].year
      month = article[:pubDate].strftime('%m')
      day = article[:pubDate].strftime('%d')
      File.join(output_dir, "#{year}-#{month}-#{day}-#{sanitize_title_for_filename(article[:post_name])}#{@extension}")
    end

    def build_frontmatter(article)
      content =  "---\n"
      content << "title: #{article[:title]}\n"
      content << "date: #{article[:pubDate].to_date}\n"
      content << "tags:\n"
      article[:categories].each do |category|
        content << "  - ""#{category}""\n"
      end
      content << "---\n"
    end

    def sanitize_title_for_filename(filename)
      filename.gsub(/[^\w\s_-]+/, '')
        .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2')
        .gsub(/\s+/, '_')
        .downcase
    end

    def output_file(article)
      file = File.open(build_filename(article), 'w')
      begin
        file.write(build_frontmatter(article))
        file.write(article[:reformatted_content])
      ensure
        file.close
      end
    end

  end
end