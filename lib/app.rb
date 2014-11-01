require 'pathname'

class App
  def initialize(path)
    @path = path
  end

  def name
    File.basename(@path)
  end

  def url
    "http://#{name}.#{Powapps.domain}/"
  end

  # Returns true if the symlinks target doesn't exist
  def dead?
    !Pathname.new(@path).realpath rescue true
  end

  def favicon
    Favicon.new(@path).source
  end
end
