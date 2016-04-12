Wordpress to Middleman (W2M) Exporter
=====================================

A Ruby Script that will convert your exported Wordpress XML into markdown files with the appropriate [frontmatter](http://middlemanapp.com/basics/frontmatter/) metadata so that they are consumable by Middleman.

Getting Started
----
1. Clone this Github locally. Add this to your Middleman project's Gemfile and bundle install:
```
gem 'wordpress-to-middleman', path: '<your local path>'
```

2. Run the program using the following commands:

```
require 'wordpress-to-middleman'
wtom = WordpressToMiddleman::Parser.new(
	wordpress_xml_file_path: <path to wordpress export xml file>, 
	output_dir: <directory where files will be output>, 
	original_domain: <original url for your website, i.e. http://www.greenspudtrades.com/>, 
	new_domain: <new base url for your website (nil if same)>
	)
wtom.parse
```

		
### Migrating Images

Wordpress stores images in the folder `wp-content/uploads/{year}/{month}/{filename}`. You want to copy all of the files
in this `uploads` folder into your Middleman project's `source/images` folder.

Example:
`wp-content/uploads/2015/09/Main_thinkorswim__build_1876_16_.png`

W2M will convert this to the path:
`images/2015/09/Main_thinkorswim__build_1876_16_.png`

See the file `lib/wordpress-to-middleman/parse_images.rb`. Note that the new greenspudtrades.com uses a custom
Middleman partial for displaying images, which this conversion program will reformat all images to use.

Gemified Version by Winston Kotzan
----------------------------------
This is a fork of the original worpress-to-middleman program designed to be more 'OO'. It is a little rough
as it was mainly used to converting www.greenspudtrades.com to Middleman. The original Greenspud Trades
website was running Wordpress version 3.9. Feel free to submit a pull request if you have ideas for making it
more end-user friendly.

To see the original version of this program: [https://github.com/salmansqadeer/wordpress-to-middleman](https://github.com/salmansqadeer/wordpress-to-middleman)



### Please Note that this is a work in progress.  Contributions welcome.


