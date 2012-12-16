require 'rubygems'
require 'rack'
require 'erb'
require 'pathname'

class Powapps
  VERSION = '0.2.3'

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    @domain = domain
    @apps = apps
  end

  def response
    path = File.expand_path('../../views/layout.html.erb', __FILE__)
    layout = ERB.new(File.read(path)).result(binding)
    Rack::Response.new(layout)
  end

  # The domain to keep apps relative to.
  # Returns "10.0.0.1.xip.io" if we access at powapps.10.0.0.1.xip.io
  def domain
    @request.host.gsub /^\w+\./, ''
  end

  # Array of Pow apps, minus this app itself
  def apps
    directories.map do |path|
      AppItem.new(path, @domain)
    end.reject{ |app| app.name == File.basename(Dir.pwd) }
  end

  # Directories and symlinks in ~/.pow
  def directories
    Dir[File.join(Dir.pwd, '..', '*')]
  end
end

class AppItem
  def initialize(path, domain)
    @path, @domain = path, domain
  end

  def name
    File.basename(@path)
  end

  def url
    "http://#{name}.#{@domain}/"
  end

  # Returns true if the symlinks target doesn't exist
  def dead?
    !Pathname.new(@path).realpath rescue true
  end
end
