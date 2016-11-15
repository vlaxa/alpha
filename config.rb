require_relative 'lib/sass-functions'

config[:layouts_dir] = '_layouts'

activate :asciidoc, attributes: {
  'source-language' => 'sh',
  'source-highlighter' => 'coderay',
  'coderay-css' => 'style',
}

configure :development do
  Bundler.require(:development)

  # Reload the browser automatically whenever files change.
  activate :livereload, no_swf: true, host: '127.0.0.1'
end

# Build-specific configuration
configure :build do
  activate :minify_css
end

compass_config do |conf|
end
