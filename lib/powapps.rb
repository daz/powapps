require 'rubygems'
require 'rack'
require 'erb'

class Powapps
  VERSION = '1.0'

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
    Rack::Response.new(layout, 200, { 'Content-Type' => 'text/html' })
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
