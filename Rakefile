# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'rake/extensiontask'

Hoe.spec 'fnmatch' do
  developer('Shilo Ayalon', 'shiloayalon@gmail.com')

  self.readme_file   = 'README.markdown'
  self.history_file  = 'HISTORY.markdown'
  #self.extra_rdoc_files  = FileList['*.rdoc']
  self.extra_dev_deps << ['rake-compiler', '>= 0']
  self.spec_extras = { :extensions => ["ext/fnmatch/extconf.rb"] }

  Rake::ExtensionTask.new('fnmatch', spec) do |ext|
    ext.lib_dir = File.join('lib', 'fnmatch')
  end

  # self.rubyforge_name = 'fnmatchx' # if different than 'fnmatch'
end

Rake::Task[:test].prerequisites << :compile
