require 'base64'

class Favicon
  def initialize(app_root)
    locate(app_root)
  end

  def source
    if exists?
      "data:#{mime_type};base64,#{data}"
    else
      '/default_favicon.png'
    end
  end

  # Base 64 encoding of the favicon
  def data
    Base64.encode64(File.open(@path, 'r').read).gsub(/\n/, '')
  end

  # Mime type of favicon
  def mime_type
    Rack::Mime::MIME_TYPES.merge!('.ico' => 'image/x-icon') # image/vnd.microsoft.icon won't render in IE8
    Rack::Mime.mime_type(File.extname(@path))
  end

  # Returns true unless we can't find a favicon or if favicon file is empty
  def exists?
    File.size?(@path).to_i != 0
  end

  private

  # Look in [app path]/public/ for a favicon file
  def locate(app_root)
    %w[png gif ico].each do |ext|
      @path = File.join(app_root, 'public', "favicon.#{ext}")
      break if exists?
    end
  end
end
