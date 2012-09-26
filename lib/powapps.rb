require 'rubygems'
require 'rack'
require 'erb'

class Powapps
  VERSION = '0.2.3'

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @domain = domain
    @apps = apps
    @dead_apps = dead_apps
  end

  def response
    path = File.expand_path('../../views/layout.html.erb', __FILE__)
    layout = ERB.new(File.read(path)).result(binding)
    Rack::Response.new(layout)
  end

  # The domain to keep apps relative to.
  # Returns "10.0.0.1.xip.io" if we access at powapps.10.0.0.1.xip.io
  def domain
    @request.host.split('.')[1..-1].join('.')
  end

  # App names, minus this app itself
  def apps
    directories.map{ |d| File.basename(d) }.reject{ |a| a[File.basename(Dir.pwd)] }
  end

  # Directories under ~/.pow
  def directories
    Dir[File.join(ENV['HOME'], '.pow', '*')]
  end

  # App names of dead symlinks
  def dead_apps
    directories.select do |d|
      !File.exists?(File.readlink(d)) rescue false
    end.map{ |d| File.basename(d) }
  end
end
