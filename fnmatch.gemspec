require 'rubygems'
require 'rake'

# my first gem, so I'll just throw everything in
# and hope for the best
files = FileList['lib/**/*.rb', 
                 'ext/**/*.c',
                 'ext/**/*.h',
                 'ext/**/*.rb',
                 'spec/**/*.rb'].to_a

Gem::Specification.new do |s|
  s.name         = 'fnmatch'
  s.require_path = '.'
  s.version      = '0.1.0'
  s.summary      = "Perform simple glob syntax matching in Ruby"
  s.description  = <<-EOF
    A very basic wrapper around C-lib's <fnmatch.h> 
    for efficient glob matching on strings. The idea is
    to provide a simpler matching mechanism for when using
    regular expressions is an overkill (both for your app
    and for performance).
  EOF
  s.author       = "Shilo Ayalon"
  s.email        = "shiloayalon@gmail.com"
  s.files        = files
  s.homepage     = 'http://github.com/shiloa/fnmatch'
  s.license      = 'MIT/X11'
 
  # whoa
  s.extensions    << 'ext/fnmatch/extconf.rb'
  s.require_paths << 'ext'
  s.require_paths << 'lib'

  s.post_install_message  = "\nThis is my first gem, so be nice.. And careful.\n\n"
  s.required_ruby_version = '>= 1.8.7'

  s.test_files = Dir.glob('spec/*_spec.rb')
end
