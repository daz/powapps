require 'rack'
require 'erb'

class Powapps
  VERSION = '0.2.0'

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    @domain = domain
    @apps = apps
    path = File.expand_path("../views/layout.html.erb", __FILE__)
    layout = ERB.new(File.read(path)).result(binding)
    Rack::Response.new(layout)
  end

  # The domain to keep apps relative to.
  # Returns "10.0.0.1.xip.io" if we access at powapps.10.0.0.1.xip.io
  def domain
    @request.host.split('.')[1..-1].join('.')
  end

  # Array of all directories under ~/.pow (minus powapps)
  def apps
    Dir[File.join(Dir.home, '.pow', '*')].map{ |dir| File.basename(dir) }.reject{ |f| f[File.basename(Dir.pwd)] }
  end
end
