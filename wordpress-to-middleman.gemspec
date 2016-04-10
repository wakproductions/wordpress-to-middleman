# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wordpress-to-middleman/version'

Gem::Specification.new do |spec|
  spec.name          = 'wordpress-to-middleman'
  spec.version       = WordpressToMiddleman::VERSION
  spec.authors       = ['Salman Suhail', 'Winston Kotzan']
  spec.email         = ['wak@wakproductions.com']
  spec.summary       = %q{A Gemified adaptation of the original https://github.com/salmansqadeer/wordpress-to-middleman}
  spec.description   = %q{Used for conversion of greenspudtrades.com}
  spec.homepage      = 'https://github.com/wakproductions/wordpress-to-middleman'
  spec.license       = 'GNU Public License'

  spec.files         = [`git ls-files`.split($/)] + Dir['lib/**/*']
  # spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'bundler',  '~> 1.5'
  spec.add_dependency 'rake',     '>= 11.1.2'
  spec.add_dependency 'upmark',   '~> 0.9'
  spec.add_dependency 'html2md',  '~> 0.1'
  spec.add_dependency 'nokogiri', '~> 1.6'
end
