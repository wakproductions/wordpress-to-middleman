module WordpressToMiddleman
  module ParseCDATA
    # Extracts the contents of a CDATA tag.
    # Input:
    #   "<![CDATA[Trading 101]]>"
    # Output:
    #   "Trading 101"
    def extract_from_cdata(string_with_tag)
      content = string_with_tag.match /<!\[CDATA\[(.*)\]\]>/m
      content ? content[1] : string_with_tag
    end
  end
end