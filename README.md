Wordpress to Middleman (W2M) Exporter
=====================================

A Ruby Script that will convert your exported Wordpress XML into markdown files with the appropriate [frontmatter](http://middlemanapp.com/basics/frontmatter/) metadata so that they are consumable by Middleman.

Getting Started
----
1. Clone this Github locally. Add this to your Middleman project's Gemfile and bundle install:
```
gem 'wordpress-to-middleman', path: '<your local path>'
```


Old Instructions:
1.  Open up the wordpress_to_middleman.rb file and setup the following three variables
	- WORDPRESS_XML_FILE_PATH (The path to the exported wordpress.xml file)
	- OUTPUT_PATH (The path where all of the markdown posts will be saved)
	- ORIGINAL_DOMAIN (The domain of the original website)
	- SEPARATE_CATEGORIES_FROM_TAGS (List categories as its own YAML attribute. Defalut: `false` - all categories will be listed as tags)
	- CONVERT_FROM_HTML (Convert HTML tags to markdown)
2.  Ensure that all of the required gems are installed (Gemfile is included, so you can run `bundle`) - three in specific that are required are:
	- nokogiri
	- upmark
	- html2md
3.  Remove the following lines from the exported Wordpress XML (They mess with nokogiri's parser):
		<!-- Debugging help, do not remove -->
		<meta name="Framework" content="Kpress" />
		<meta name="Theme Version" content="1.4.1" />
		<meta name="Framework Version" content="1.4" />
		<meta name="CMS Version" content="3.5.2" />

3.  In the terminal, navigate to the folder where the project has been saved, and run 
		ruby wordpress_to_middleman.rb
		
### Migrating Images

Wordpress stores images in the folder `wp-content/uploads/{year}/{month}/{filename}`. You want to copy all of the files
in this `uploads` folder into your Middleman project's `source/images` folder.

Example:
`wp-content/uploads/2015/09/Main_thinkorswim__build_1876_16_.png`

W2M will convert this to the path:
`images/2015/09/Main_thinkorswim__build_1876_16_.png`

Gemified Version by Winston Kotzan
----------------------------------
This is a fork of the original worpress-to-middleman program designed to be more 'OO'. Some of the
functionality in this version will be specific to converting www.greenspudtrades.com to Middleman. The website
this was used on was running Wordpress 3.9.

To see the original version of this program: [https://github.com/salmansqadeer/wordpress-to-middleman](https://github.com/salmansqadeer/wordpress-to-middleman)



### Please Note that this is a work in progress.  Contributions welcome.


