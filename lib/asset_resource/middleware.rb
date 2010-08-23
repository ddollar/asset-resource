require "asset_resource"

class AssetResource::Middleware

  attr_reader :app, :options

  def initialize(app, options={})
    @app = app
    @options = options

    if options[:handlers] then
      options[:handlers].each do |handler, mime_type|
        handle handler.to_sym, mime_type
      end
    else
      handle :scripts, "text/javascript"
      handle :styles,  "text/css"
    end

    translator :less do |filename|
      begin
        require "less"
        Less::Engine.new(File.read(filename)).to_css
      rescue LoadError
        raise "Tried to translate a less file but could not find the library.\nTry adding this to your Gemfile:\n  gem \"less\""
      end
    end

    translator :sass do |filename|
      begin
        require "sass"
        Sass::Engine.new(File.read(filename), :load_paths => [File.dirname(filename)]).render
      rescue LoadError
        raise "Tried to translate a sass file but could not find the library.\nTry adding this to your Gemfile:\n  gem \"haml\""
      end
    end
  end

  def call(env)
    if env["PATH_INFO"] =~ %r{\A/assets/(.+)\B}
      type = $1.split(".").first
      return app.call(env) unless handles?(type)
      return [200, asset_headers(type), process_files(files_for(type))]
    end
    app.call(env)
  end

private ######################################################################

  def asset_headers(type)
    headers = options[:asset_headers] || { "Cache-Control" => "public, max-age=86400" }
    headers.merge("Content-Type" => handlers[type.to_sym])
  end

  def base_path
    options[:base_path] || "public"
  end

  def files_for(type)
    Dir.glob(File.expand_path(File.join(base_path, type, "**", "*"))).select do |file|
      File.exist?(file) && File.basename(file)[0..0] != "_"
    end
  end

  def process_files(files)
    data = files.inject("") do |accum, file|
      ext = File.extname(file)[1..-1]
      accum << translator(ext).call(file)
    end
    StringIO.new(data)
  end

  def handlers
    @handler ||= {}
  end

  def handles?(type)
    handlers.keys.include?(type.to_sym)
  end

  def handle(type, mime_type)
    handlers[type.to_sym] = mime_type
  end

  def default_translator
    lambda { |filename| File.read(filename) }
  end

  def translators
    @translators ||= Hash.new(default_translator)
  end

  def translator(type, &block)
    return default_translator unless type
    translators[type.to_sym] = block if block_given?
    translators[type.to_sym]
  end

end
