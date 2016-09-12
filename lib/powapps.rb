require 'rubygems'
require 'rack'
require 'erb'

class Powapps
  VERSION = '1.5'

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    set_domain
    set_apps
  end

  def response
    path = File.expand_path('../../views/layout.html.erb', __FILE__)
    layout = ERB.new(File.read(path)).result(binding)
    Rack::Response.new(layout, 200, { 'Content-Type' => 'text/html' })
  end

  def self.domain
    @@domain
  end

  private

    # Directories and symlinks in ~/.pow
    def directories
      Dir[File.join(ENV['HOME'], '.pow', '*')]
    end

    # Set the domain to keep apps relative to.
    # e.g. "10.0.0.1.xip.io" if accessed from http://powapps.10.0.0.1.xip.io or
    # "dev" if it's from http://powapps.dev
    def set_domain
      @@domain = @request.host.split('.')[1..-1].join('.')
    end

    # Array of Pow apps, minus this app itself
    def set_apps
      @apps = directories.map do |path|
        App.new(path)
      end.reject { |app| app.name == File.basename(Dir.pwd) }
    end
end
