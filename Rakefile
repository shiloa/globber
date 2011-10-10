# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'rake/extensiontask'

Hoe.spec 'globber' do
  developer('Shilo Ayalon', 'shiloayalon@gmail.com')

  self.readme_file   = 'README.markdown'
  #self.history_file  = 'HISTORY.markdown'
  #self.extra_rdoc_files  = FileList['*.rdoc']
  self.extra_dev_deps << ['rake-compiler', '>= 0']
  self.spec_extras = { :extensions => ["ext/globber/extconf.rb"] }

  Rake::ExtensionTask.new('globber', spec) do |ext|
    ext.lib_dir = File.join('lib', 'globber')
  end

  # self.rubyforge_name = 'globberx' # if different than 'globber'
end

#Rake::Task[:test].prerequisites << :compile
