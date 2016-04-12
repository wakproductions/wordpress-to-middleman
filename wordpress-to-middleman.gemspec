# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wordpress-to-middleman/version'

Gem::Specification.new do |s|
  s.name          = 'wordpress-to-middleman'
  s.version       = WordpressToMiddleman::VERSION
  s.authors       = ['Salman Suhail', 'Winston Kotzan']
  s.email         = ['wak@wakproductions.com']
  s.summary       = %q{A Gemified adaptation of the original https://github.com/salmansqadeer/wordpress-to-middleman}
  s.description   = %q{Used for conversion of greenspudtrades.com}
  s.homepage      = 'https://github.com/wakproductions/wordpress-to-middleman'
  s.license       = 'GNU Public License'

  s.files         = [`git ls-files`.split($/)] + Dir['lib/**/*']
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'bundler',  '>= 1.5'
  s.add_dependency 'rake',     '>= 11.1.2'

  s.add_dependency 'hashie',   '>= 3.4'
  s.add_dependency 'html2md',  '>= 0.1'
  s.add_dependency 'upmark',   '>= 0.9'
  s.add_dependency 'pry-byebug', '>= 3.3'
end
