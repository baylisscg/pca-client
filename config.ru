# config.ru

require 'rubygems' if RUBY_VERSION =~ /^1\.8/

unless defined? Bundler  
 require 'bundler'
 Bundler.setup
end

$LOAD_PATH << './lib'

require 'pca' unless defined? PCA

run PCA::Application 