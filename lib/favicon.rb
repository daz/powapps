require 'base64'

class Favicon
  SEARCH_PATHS = %w(app/assets/images app/assets assets public/images public)
  EXTENSIONS   = %w(png gif ico)
  DEFAULT_PATH = '/default_favicon.png'

  def initialize(app)
    @app = app
    locate
  end

  def url
    exists? ? data_uri : DEFAULT_PATH
  end

  def exists?
    !!@path
  end

  private

    # Look in `SEARCH_PATHS` for a non-empty favicon file with extension in `EXTENSIONS`
    def locate
      return if @app.dead?
      file_names = EXTENSIONS.map { |ext| "favicon.#{ext}" }
      paths = SEARCH_PATHS.product(file_names).map { |path| File.join(@app.path, path) }
      paths.each do |path|
        next if File.size?(path).to_i == 0
        @path = path
        break
      end
    end

    # Data URI for favicon
    def data_uri
      data = Base64.encode64(File.open(@path, 'r').read).gsub(/\n/, '')
      "data:#{mime_type};base64,#{data}"
    end

    # Mime type of favicon
    def mime_type
      # image/vnd.microsoft.icon won't render in IE8
      Rack::Mime::MIME_TYPES.merge!('.ico' => 'image/x-icon')
      Rack::Mime.mime_type(File.extname(@path))
    end
end
